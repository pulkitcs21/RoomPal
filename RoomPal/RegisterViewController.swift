//
//  RegisterViewController.swift
//  RoomPal
//


import Foundation
import UIKit
import Firebase

class RegisterViewController: UIViewController {
    @IBOutlet var firstNameTextField: UITextField!
    @IBOutlet var lastNameTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var confirmPasswordTextField: UITextField!
    
    var selectedUID: String!
    
    
    @IBAction func registerPressed(_ sender: AnyObject) {
        //TODO: Set up a new user on our Firbase database
        //The callback parameter tells us whether the process was successful or not, if there were any errors PRESS ENTER
        handleRegister(email: emailTextField.text!, password: passwordTextField.text!,
            callback: { (firebaseUser: Firebase.User?) in
            if (firebaseUser != nil) {
                self.selectedUID = firebaseUser!.uid
                print("SUCCESS")
                self.selectedUID = firebaseUser!.uid
                self.addUserToDatabase(uid: self.selectedUID)
            }
            self.performSegue(withIdentifier: "afterRegistered", sender: self)
        })
    }
    
    func handleRegister(email: String, password: String, callback: @escaping (Firebase.User?) -> ()) {
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if error != nil {
                print(error!)
                callback(nil)
            }
            callback(user)
        }
    }
    
    
    func accessDatabase() -> DatabaseReference {
        var ref: DatabaseReference!
        ref = Database.database().reference(fromURL: "https://roompal-90e17.firebaseio.com/")
        return ref
    }
    
    func addUserToDatabase(uid: String) {
        print("Attempting to access database....")
        let ref = accessDatabase()
        print("Database accessed!")
        //Auth.auth().currentUser?.uid
        print(Auth.auth().currentUser?.uid)
        let usersReference = ref.child("users").child((Auth.auth().currentUser?.uid)!)
        let values = [self.firstNameTextField.text!, self.lastNameTextField.text!, self.emailTextField.text!, self.confirmPasswordTextField.text!]
        usersReference.setValue(values)
        print("Data written")
        let membersReference = ref.child("members")
        let newMember = membersReference.child(uid)
        newMember.setValue("\(self.firstNameTextField.text!) \(self.lastNameTextField.text!)")
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
}
