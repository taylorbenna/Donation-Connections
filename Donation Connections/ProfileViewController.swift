//
//  ProfileViewController.swift
//  Donation Connections
//
//  Created by Taylor Benna on 2016-06-16.
//  Copyright © 2016 Taylor Benna. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    var currentCharity:Charity?
    var currentDoner:Donator?
    @IBOutlet weak var navBar: UINavigationBar!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        getCharity { (success) in
            if !success {
                self.getDoner()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func logOutPressed(sender: UIButton) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(nil, forKey: "user")
        performSegueWithIdentifier("logOut", sender: self)
    }
    
    func updateCharityProfile() {
        let charProfile = CharityProfileView.init(frame: CGRectZero)
        
        charProfile.currentUser = currentCharity
        
        view.addSubview(charProfile)
        charProfile.translatesAutoresizingMaskIntoConstraints = false
        
        charProfile.topAnchor.constraintEqualToAnchor(navBar.bottomAnchor).active = true
        charProfile.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor).active = true
        charProfile.leadingAnchor.constraintEqualToAnchor(view.leadingAnchor).active = true
        charProfile.trailingAnchor.constraintEqualToAnchor(view.trailingAnchor).active = true
        
    }
    
    func updateDonerProfile() {
        let donProfile = DonerProfileView.init(frame: CGRectZero)
        
        donProfile.currentUser = currentDoner
        
        view.addSubview(donProfile)
        donProfile.translatesAutoresizingMaskIntoConstraints = false
        
        donProfile.topAnchor.constraintEqualToAnchor(navBar.bottomAnchor).active = true
        donProfile.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor).active = true
        donProfile.leadingAnchor.constraintEqualToAnchor(view.leadingAnchor).active = true
        donProfile.trailingAnchor.constraintEqualToAnchor(view.trailingAnchor).active = true
        
    }
    
    func getCharity(completion:(success: Bool) -> ()){
        
        let defaults = NSUserDefaults.standardUserDefaults()
        let username = defaults.stringForKey("user")
        
        
        let query = Charity.query()!
        query.whereKey("charityOwner", equalTo: username!)
        query.getFirstObjectInBackgroundWithBlock { (object, error) in
            
            if let charity = object as? Charity {
                self.currentCharity = charity
                self.currentDoner = nil
                self.updateCharityProfile()
                completion(success: true)
            } else {
                completion(success: false)
            }
            
        }
    }
    
    func getDoner() {
        let defaults = NSUserDefaults.standardUserDefaults()
        let username = defaults.stringForKey("user")
        
        
        let query = Donator.query()!
        query.whereKey("username", equalTo: username!)
        query.getFirstObjectInBackgroundWithBlock { (object, error) in
            
            if let doner = object as? Donator {
                self.currentDoner = doner
                self.currentCharity = nil
                self.updateDonerProfile()
            }
            
        }

    }
    
    @IBAction func editButtonPressed(sender: UIButton) {
        
        if currentCharity != nil {
            performSegueWithIdentifier("editCharity", sender: self)
        } else {
            performSegueWithIdentifier("editDoner", sender: self)
        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "editCharity" {
            print("Charity")
        } else if segue.identifier == "editDoner" {
            print("Doner")
        }
    }
    
    
}

