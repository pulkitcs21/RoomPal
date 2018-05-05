//
//  WelcomeViewController.swift
//  RoomPal
//

import Foundation
import UIKit
import Firebase

class WelcomeViewController: UIViewController {
//    let loginViewController = UIViewController() as! LoginViewController
    
    @IBOutlet weak var loginButton: UIButton!
    
    
    //connect the login and register functions
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        //print("the login button was pressed")
        //performSegue(withIdentifier: "goToLogin", sender: self)
        performSegue(withIdentifier: "goToLogin", sender: self)
    }
    //    @IBAction func registerButtonPressed(_ sender: Any) {
//        //segue to the registerViewController
//    }
    
    @IBAction func registerButtonPressed(_ sender: UIButton) {
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




