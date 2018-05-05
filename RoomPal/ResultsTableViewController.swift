//
//  ResultsTableViewController.swift
//  RoomPal
//


import Foundation
import UIKit
import Firebase

class ResultsTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    var dataDict:[String:[String]]!
    var usersArray:[User] = []
    var currentUser:User!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = usersArray[indexPath.row].description
        return cell
    }
    
    @IBOutlet var resultsTableView: UITableView!
    
    @IBAction func LogoutButton(_ sender: UIBarButtonItem) {
        // Firebase code for logging out goes here.
        //TODO: Log out the user and send them back to WelcomeViewController
        do {
            // try: line of code that could potentially cause trouble
            try Auth.auth().signOut()
            //take the user back to where they were
            print("signing out..")
            navigationController?.popToRootViewController(animated: true)
        }
        catch {
            print("There was a problem signing out")
        }
    }
    
    func retrieveUsers(){
        var count = 0
        let ref = accessDatabase()
        let usersReference = ref.child("users")
        usersReference.observeSingleEvent(of: DataEventType.value, with: {(snapshot)in
            let iterator = snapshot.children
            while let child = iterator.nextObject() as! DataSnapshot! {
                print("Key: \(child.key)")
                print("Value: \(child.value)")
                print("Child: \(child)")
                if(self.dataDict == nil){
                    self.dataDict = [child.key: (child.value as? [String])!]
                }
                else{
                    self.dataDict[child.key] = child.value as? [String]
                }
            }
            self.populateUsersArray()
            self.usersArray = self.results(users: self.usersArray, me: self.currentUser!)
            self.resultsTableView.reloadData()
        })
    }
    
    func populateUsersArray(){
        var count = 0
        for i in dataDict{
            var attributes = i.value
            var boolArray:[Bool] = []
            if(attributes[4] == "true"){
                boolArray.append(true)
            }
            else{
                boolArray.append(false)
            }
            
            if(attributes[5] == "true"){
                boolArray.append(true)
            }
            else{
                boolArray.append(false)
            }
            
            if(attributes[6] == "true"){
                boolArray.append(true)
            }
            else{
                boolArray.append(false)
            }
            
            if(attributes[7] == "true"){
                boolArray.append(true)
            }
            else{
                boolArray.append(false)
            }
            
            if(attributes[13] == "true"){
                boolArray.append(true)
            }
            else{
                boolArray.append(false)
            }
            
            var newUser = User("\(attributes[0]) \(attributes[1])", i.key, boolArray[0], Int(attributes[8])!, boolArray[1], boolArray[2], boolArray[3], Int(attributes[10])!, Int(attributes[11])!, Int(attributes[12])!, Int(attributes[9])!, boolArray[4])
            print(i.key)
            if(i.key == Auth.auth().currentUser?.uid){
                currentUser = newUser
            }
            else{
                usersArray.append(newUser)
            }
        }
        print(usersArray)
    }
    
    func accessDatabase() -> DatabaseReference {
        var ref: DatabaseReference!
        ref = Database.database().reference(fromURL: "https://roompal-90e17.firebaseio.com/")
        return ref
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Doy  setup after loading the view, typically from a nib.
        resultsTableView.delegate = self
        resultsTableView.dataSource = self
        retrieveUsers()
        print(dataDict)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func results(users: [User], me: User) -> [User]{
        let resultsheap = Results()
        var sortedUsers: [User] = []
        for i in users{
            let score: Int = me.compare(other: i)
            resultsheap.add(score: score, user: i)
        }
        while !resultsheap.isEmpty(){
            sortedUsers.append(resultsheap.deleteMax().user)
        }
        return sortedUsers
    }
}
