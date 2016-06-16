//
//  DonatorView.swift
//  Donation Connections
//
//  Created by Taylor Benna on 2016-06-14.
//  Copyright © 2016 Taylor Benna. All rights reserved.
//

import UIKit
import Parse

class DonatorView: UIView, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var delegate:SignUpProtocol?
    var user:PFUser?

    @IBOutlet var view: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!

    let imagePicker = UIImagePickerController()
    
    //MARK: Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        NSBundle.mainBundle().loadNibNamed("DonatorSignUp", owner: self, options: nil)[0] as! UIView
        self.addSubview(view)
        view.frame = self.bounds
        imagePicker.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        NSBundle.mainBundle().loadNibNamed("DonatorSignUp", owner: self, options: nil)[0] as! UIView
        self.addSubview(view)
        view.frame = self.bounds
        imagePicker.delegate = self

    }

    //MARK: Image View
    
    @IBAction func imageViewTapped(sender: UITapGestureRecognizer) {
        
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .PhotoLibrary
        
        delegate?.imagePickerPresent(imagePicker)
        
    }
    
    //MARK: Validation
    
    func checkNames() -> Bool{
        if (firstNameTextField.text == "" || lastNameTextField.text == "") {
            delegate!.sendInfoForAlert("Whats your name??", desc: "Please make sure you have entered your first and last name.")

            return false
        }
        return true
    }
    
    func checkImage() -> Bool {
        if imageView.image == nil {
            delegate!.sendInfoForAlert("No Image", desc: "Please select an Image before continuing.")
            return false
        }
        return true
    }
    
    func validate() -> Bool{
        if !checkNames() {
            return false
        }
        if !checkImage() {
            return false
        }
        return true
    }
    
    //MARK: Buttons
    
    @IBAction func submitButtonPressed(sender: UIButton) {
        if validate() {
            let donator = Donator()
            donator.firstName = firstNameTextField.text!
            donator.lastName = lastNameTextField.text!
            donator.username = user!.username!
            donator.photo = PFFile(data: UIImageJPEGRepresentation(imageView.image!, 0.5)!)!

            donator.saveInBackgroundWithBlock {
                (success: Bool, error: NSError?) -> Void in
                if (success) {
                    self.delegate!.didFinishSignUp()
                } else {
                    self.delegate!.sendInfoForAlert("Trouble Saving", desc: "Something seems to have gone wrong. Try it again!")
                }
            }

        }
        
        // send info for donator
        
    }
    
    @IBAction func cancelButtonPressed(sender: UIButton) {
        delegate!.xibCancelButton()
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.contentMode = .ScaleAspectFit
            imageView.image = pickedImage
        }
        
        delegate!.xibCancelButton()
    }
    
    @IBAction func backgroundTapped(sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
}
