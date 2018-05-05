//
//  LoginViewController.swift
//  RoomPal


import Foundation
import UIKit
import Firebase

class LoginViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField?
    @IBOutlet weak var passwordTextField: UITextField?
    
    var selectedUID: String!
    
   /* @IBAction func loginButtonPresed(_ sender: Any) {
        //make sure email and password text fields are not empty
        
        //Log in using Firebase
        Auth.auth().signIn(withEmail: (emailTextField?.text!)!, password: (passwordTextField?.text!)!) { (user, error) in
            if error != nil {
                print("There was an error: " + error!.localizedDescription)
            }
            else {
                print("login was successful")
                self.performSegue(withIdentifier: "goToLogin", sender: self)
            }
        }
    }*/
    
    @IBAction func submitButton(_ sender: Any) {
        handleLogIn(email: (emailTextField?.text!)!, password: (passwordTextField?.text!)!) { (firebaseUser: Firebase.User?) in
            //The result of the handleLogIn function is stored in the firebaseUser variable. If it is nil, the log in attempt failed. Firebase will already handle most potential errors with this operation, so if this point is reached, firebaseUser really shouldn’t ever be nil anyways
            if firebaseUser != nil{
                //Sign in successful
                print("Sign in is successful")
                self.selectedUID = firebaseUser!.uid
                print(self.selectedUID)
                print(Auth.auth().currentUser!.uid)
            }
        }
        self.performSegue(withIdentifier: "afterLogin", sender: self)
    }
    
    func handleLogIn(email: String,password: String, callback: @escaping (Firebase.User?) -> ()) {
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
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

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}






