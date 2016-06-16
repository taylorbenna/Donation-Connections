//
//  SignUpViewController.swift
//  Donation Connections
//
//  Created by Taylor Benna on 2016-06-13.
//  Copyright © 2016 Taylor Benna. All rights reserved.
//

import UIKit
import Parse

class SignUpViewController: UIViewController, SignUpProtocol {
    
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var userTypeSegment: UISegmentedControl!
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet var rootView: UIView!
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var navBar: UINavigationBar!
    
    var charView:CharityView!
    var donView:DonatorView!
    var currentUser:PFUser?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func saveUser(completion:(success: Bool) -> ()){
        
        let user = PFUser()
        user.username = usernameTextField.text
        user.password = passwordTextField.text
        currentUser = user
        
        user.signUpInBackgroundWithBlock {
            (succeeded: Bool, error: NSError?) -> Void in
            if let error = error {
                let errorString = error.userInfo["error"] as? String
                self.showAlert("Something went wrong!", descText: errorString!)
                completion(success: false)
            }else {
                
                completion(success: true)
                
            }
        }
    }
    
    // MARK: Validation
    
    func checkPassword() -> Bool{
        if (passwordTextField.text == confirmPasswordTextField.text && passwordTextField.text != "" && passwordTextField.text?.characters.count > 7) {
            return true
        }
        showAlert("Password Problem", descText: "Passwords must match, and have a minimun length of 8")
        return false
    }
    
    func checkUser() -> Bool {
        if usernameTextField.text?.characters.count < 8 {
            showAlert("Username too Short", descText: "Username must be at least 8 characters long")
            return false
        }
        return true
    }
    
    func validation() -> Bool{
        if !checkPassword() {
            return false
        }
        if !checkUser() {
            return false
        }
        
        return true
    }
    
    //MARK: Button Presses
    
    @IBAction func nextButtonPressed(sender: AnyObject) {
        if validation() {
            saveUser({ (success) in
                if success {
                    if self.userTypeSegment.selectedSegmentIndex == 0 {
                        self.donView = DonatorView.init(frame: CGRectZero)
                        self.donView.delegate = self
                        self.donView.user = self.currentUser
                        
                        self.view.addSubview(self.donView)
                        self.donView.translatesAutoresizingMaskIntoConstraints = false
                        
                        self.donView.topAnchor.constraintEqualToAnchor(self.navBar.bottomAnchor).active = true
                        self.donView.bottomAnchor.constraintEqualToAnchor(self.view.bottomAnchor).active = true
                        self.donView.leadingAnchor.constraintEqualToAnchor(self.view.leadingAnchor).active = true
                        self.donView.trailingAnchor.constraintEqualToAnchor(self.view.trailingAnchor).active = true
                        
                        UIView.transitionFromView(self.baseView, toView: self.donView, duration: 1.0, options: .TransitionFlipFromLeft, completion: nil)
                    } else {
                        self.charView = CharityView.init(frame: CGRectZero)
                        
                        self.charView.delegate = self
                        self.charView.user = self.currentUser
                        
                        self.view.addSubview(self.charView)
                        self.charView.translatesAutoresizingMaskIntoConstraints = false
                        
                        self.charView.topAnchor.constraintEqualToAnchor(self.navBar.bottomAnchor).active = true
                        self.charView.bottomAnchor.constraintEqualToAnchor(self.view.bottomAnchor).active = true
                        self.charView.leadingAnchor.constraintEqualToAnchor(self.view.leadingAnchor).active = true
                        self.charView.trailingAnchor.constraintEqualToAnchor(self.view.trailingAnchor).active = true
                        
                        UIView.transitionFromView(self.baseView, toView: self.charView, duration: 1.0, options: .TransitionFlipFromLeft, completion: nil)
                    }

                }
            })
        }
    }
    
    
    @IBAction func cancelButtonPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    //MARK: Alert
    
    func showAlert(title: String, descText: String) {
        let alert = UIAlertController(title: title, message: descText, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    //Mark: Gestures
    
    @IBAction func baseViewTapped(sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    //MARK: Delegate Functions
    
    func xibCancelButton() {
        dismissViewControllerAnimated(true, completion: nil)
    }

    func imagePickerPresent(imagePicker: UIImagePickerController) {
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func sendInfoForAlert(title: String, desc: String) {
        showAlert(title, descText: desc)
    }
    
    func didFinishSignUp(){
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(currentUser?.username, forKey: "user")
        dismissViewControllerAnimated(true, completion: nil)
    }


}
