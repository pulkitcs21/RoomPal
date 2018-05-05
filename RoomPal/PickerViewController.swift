//
//  PickerViewController.swift
//  RoomPal
//


import Foundation
import UIKit
import Firebase

class PickerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if(pickerView == overnightGuestPicker){
            return String(overnightArray[row])
        }
        if(pickerView == bedTimePicker){
            return String(bedtimeArray[row])
        }
        if(pickerView == wakeUpPicker){
            return String(wakeupArray[row])
        }
        else{
            return String(messyArray[row])
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(pickerView == overnightGuestPicker){
            return overnightArray.count
        }
        if(pickerView == bedTimePicker){
            return bedtimeArray.count
        }
        if(pickerView == wakeUpPicker){
            return wakeupArray.count
        }
        else{
            return messyArray.count
        }
    }
    
    @IBOutlet weak var overnightGuestPicker: UIPickerView!
    
    @IBOutlet weak var bedTimePicker: UIPickerView!
    
    @IBOutlet weak var wakeUpPicker: UIPickerView!
    
    @IBOutlet weak var messyPicker: UIPickerView!
    
    @IBOutlet weak var partiesSegmentedControl: UISegmentedControl!
    
    var overnightArray = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    var bedtimeArray = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
    var wakeupArray = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
    var messyArray = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    var storeArr:[String]!
    
    var overnightValue:Int!
    var bedtimeValue:Int!
    var wakeupValue:Int!
    var messyValue:Int!
    var partiesValue:Bool!
    
    func determineValue() {
        overnightValue = overnightArray[overnightGuestPicker.selectedRow(inComponent: 0)]
        bedtimeValue = bedtimeArray[bedTimePicker.selectedRow(inComponent: 0)]
        wakeupValue = wakeupArray[wakeUpPicker.selectedRow(inComponent: 0)]
        messyValue = messyArray[messyPicker.selectedRow(inComponent: 0)]
        if (partiesSegmentedControl.selectedSegmentIndex == 1) {
            partiesValue = false
        }
        else if (partiesSegmentedControl.selectedSegmentIndex == 0) {
            partiesValue = true
        }
        print("Overnight value: \(overnightValue); Bedtime value: \(bedtimeValue); Wakeup value: \(wakeupValue); Messy value: \(messyValue)\n")
        storeArr = [String(overnightValue), String(bedtimeValue), String(wakeupValue), String(messyValue), String(partiesValue)]
    }
    
    var selectedUID: String!
    
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        determineValue()
        addAttributesToDatabase()
    }
    
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
                self.performSegue(withIdentifier: "showResults", sender: self)
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
        overnightGuestPicker.delegate = self
        overnightGuestPicker.dataSource = self
        
        bedTimePicker.delegate = self
        bedTimePicker.dataSource = self
        
        wakeUpPicker.delegate = self
        wakeUpPicker.dataSource = self
        
        messyPicker.delegate = self
        messyPicker.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}


