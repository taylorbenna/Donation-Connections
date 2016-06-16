//
//  ViewController.swift
//  Donation Connections
//
//  Created by Taylor Benna on 2016-06-13.
//  Copyright © 2016 Taylor Benna. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController {

    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var currentUser:PFUser!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func checkUser() -> Bool{
        if userNameTextField.text == "" {
            showAlert("Missing Username", descText: "Please enter a username to log in.")
            return false
        }
        return true
    }
    
    func checkPassword() -> Bool {
        if passwordTextField.text == "" {
            showAlert("Missing Password", descText: "please enter your password to log in.")
            return false
        } else if passwordTextField.text?.characters.count < 8 {
            showAlert("Short Password", descText: "Your password is too short, make sure it's at least 8 characters long")
            return false
        }
        return true
    }
    
    func validate() -> Bool{
        if !checkUser() {
            return false
        }
        if !checkPassword() {
            return false
        }
        return true
    }
    
    @IBAction func logInPressed(sender: UIButton) {
        
        if validate() {
            PFUser.logInWithUsernameInBackground(userNameTextField.text!, password: passwordTextField.text!) {
                (user: PFUser?, error: NSError?) -> Void in
                if user != nil {
                    self.showAlert("LOG IN", descText: "LOG IN SUCCESSFUL!")
                    self.currentUser = user
                } else {
                    print(error)
                }
            }
        }
        
    }

    func showAlert(title: String, descText: String) {
        let alert = UIAlertController(title: title, message: descText, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    @IBAction func viewTapped(sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
}

