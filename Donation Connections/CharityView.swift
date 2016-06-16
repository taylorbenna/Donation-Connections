//
//  DonatorView.swift
//  Donation Connections
//
//  Created by Taylor Benna on 2016-06-13.
//  Copyright © 2016 Taylor Benna. All rights reserved.
//

import UIKit
import Parse

class CharityView: UIView, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    var delegate:SignUpProtocol?
    var user:PFUser?
    
    @IBOutlet var view: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var bioTextView: UITextView!
    @IBOutlet weak var itemTextField: UITextField!
    @IBOutlet weak var itemTableView: UITableView!
    
    let imagePicker = UIImagePickerController()
    var items:[String] = []

    
    //MARK: Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        NSBundle.mainBundle().loadNibNamed("CharitySignUp", owner: self, options: nil)[0] as! UIView
        self.addSubview(view)
        view.frame = self.bounds
        imagePicker.delegate = self
        nameTextField.delegate = self
        itemTextField.delegate = self
        
        itemTableView.registerNib(UINib(nibName: "ItemCellXib", bundle:nil), forCellReuseIdentifier: "itemCell")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        NSBundle.mainBundle().loadNibNamed("CharitySignUp", owner: self, options: nil)[0] as! UIView
        self.addSubview(view)
        view.frame = self.bounds
        imagePicker.delegate = self
        
        itemTableView.registerNib(UINib(nibName: "ItemCellXib", bundle:nil), forCellReuseIdentifier: "itemCell")


    }
    
    // MARK: Buttons
    
    @IBAction func cancelButtonPressed(sender: AnyObject) {
        
        delegate!.xibCancelButton()
    }
    
    
    @IBAction func viewTapped(sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @IBAction func imageTapped(sender: AnyObject) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .PhotoLibrary
        
        delegate?.imagePickerPresent(imagePicker)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.contentMode = .ScaleAspectFit
            imageView.image = pickedImage
        }
        
        delegate!.xibCancelButton()
    }
    
    @IBAction func submitButtonPressed(sender: UIButton) {
        if validate() {
            let charity = Charity()
            charity.charityName = nameTextField.text!
            charity.charityBio = bioTextView.text!
            charity.charityItems = items
            charity.charityImage = PFFile(data: UIImageJPEGRepresentation(imageView.image!, 0.5)!)!
            charity.charityOwner = user!.username!
            
            charity.saveInBackgroundWithBlock {
                (success: Bool, error: NSError?) -> Void in
                if (success) {
                    self.delegate!.didFinishSignUp()
                } else {
                    self.delegate!.sendInfoForAlert("Trouble Saving", desc: "Something seems to have gone wrong. Try it again!")
                }
            }
        }
    }
    
    
    
    //MARK: Validation
    
    func checkName() -> Bool{
        if nameTextField.text == "" {
            delegate!.sendInfoForAlert("Name Missing", desc: "We're missing the name of your charity! please enter one")
            return false
        }
        return true
    }
    
    func checkBio() -> Bool {
        if bioTextView.text.characters.count < 50 {
            delegate!.sendInfoForAlert("Short Bio", desc: "Your Bio is quite short. Please make it a little longer so that people know what you're all about!")
            return false
        }
        return true
    }
    
    func checkImage() -> Bool{
        if imageView.image == nil {
            delegate!.sendInfoForAlert("No Image!", desc: "Please select an image for your charity. It's a good way to let people know who you are!")
            return false
        }
        return true
    }
    
    func checkItems() -> Bool{
        if items.count == 0 {
            delegate!.sendInfoForAlert("No Items", desc: "Please enter the items you wish to have donated, so that people know what you need!")
            return false
        }
        return true
    }
    
    func validate() -> Bool{
        if !checkName() {
            return false
        }
        if !checkBio() {
            return false
        }
        if !checkImage() {
            return false
        }
        if !checkItems() {
            return false
        }
        return true
    }
    
    //MARK: Table View
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("itemCell", forIndexPath: indexPath) as! ItemTableViewCell
        cell.itemLabel.text = items[indexPath.row]
        return cell
    }
    
    //Mark: Text Field
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        if textField == nameTextField {
            textField.endEditing(true)
            return false
        }
        if textField == itemTextField {
            items.append(itemTextField.text!)
            itemTableView.reloadData()
        }
        
        return true
        
    }
    
}
