//
//  BooleanQuestionsViewController.swift
//  
//

import Foundation
import UIKit
import Firebase

class BooleanQuestionsViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    var guestNumber: Int!
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return guestArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(guestArray[row])
    }
    
    @IBOutlet weak var liveYes: UISegmentedControl?
    var liveYesSelected: Bool = true
    @IBOutlet weak var morningYes: UISegmentedControl?
    var morningYesSelected: Bool = true
    @IBOutlet weak var smokeYes: UISegmentedControl?
    var smokeYesSelected: Bool = true
    @IBOutlet weak var drinkYes: UISegmentedControl?
    var drinkYesSelected: Bool = true
    @IBOutlet weak var guestYes: UIPickerView?
    var guestYesSelected: Int = 0
    var guestArray: [Int] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    @IBOutlet weak var nextButton: UIButton?
    
    var storeArr:[String?]!
    var keyArr = ["email", "first name", "last name", "password", "live", "morning", "smoke", "drink", "party"]
    var userDict:[String:String] = [:]
    
    func determineValue() {
        if (liveYes?.selectedSegmentIndex == 1) {
            liveYesSelected = false
        }
        else if (liveYes?.selectedSegmentIndex == 0) {
            liveYesSelected = true
        }
        if (morningYes?.selectedSegmentIndex == 1) {
            morningYesSelected = false
        }
        else if (morningYes?.selectedSegmentIndex == 0) {
            morningYesSelected = true
        }
        if (smokeYes?.selectedSegmentIndex == 1) {
            smokeYesSelected = false
        }
        else if (smokeYes?.selectedSegmentIndex == 0) {
            smokeYesSelected = true
        }
        if (drinkYes?.selectedSegmentIndex == 1) {
            drinkYesSelected = false
        }
        else if (drinkYes?.selectedSegmentIndex == 0) {
            drinkYesSelected = true
        }
        guestYesSelected = (guestYes?.selectedRow(inComponent: 0))!
        let pickerString = String(guestArray[guestYesSelected])
        storeArr = [String(liveYesSelected), String(morningYesSelected), String(smokeYesSelected), String(drinkYesSelected), pickerString]
        addAttributesToDatabase()
    }
    
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        determineValue()
        print("live: \(liveYesSelected). morning: \(morningYesSelected), smoke: \(smokeYesSelected), drink: \(drinkYesSelected)liveYesSelected")
        performSegue(withIdentifier: "afterBooleanQuestions", sender: self)
    }
    
    var selectedUID: String!
    
    
    func addAttributesToDatabase(){
        var appArr:[String?]!
        let ref = accessDatabase()
        let usersRef = ref.child("users")
        let idRef = usersRef.child(Auth.auth().currentUser!.uid)
        print(Auth.auth().currentUser!.uid)
        idRef.observeSingleEvent(of: DataEventType.value, with: {(snapshot) in
            if let arr = snapshot.value as? [String] {
                print("Array being created")
                print(arr)
                appArr = arr
                for i in self.storeArr{
                    appArr.append(i)
                }
                print("Store Array: \(appArr)")
                idRef.setValue(appArr)
            }
        })
    }
   
    func accessDatabase() -> DatabaseReference {
        var ref: DatabaseReference!
        ref = Database.database().reference(fromURL: "https://roompal-90e17.firebaseio.com/")
        return ref
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guestYes?.delegate = self
        guestYes?.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}


