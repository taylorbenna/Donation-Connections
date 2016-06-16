//
//  ProfileViewController.swift
//  Donation Connections
//
//  Created by Taylor Benna on 2016-06-16.
//  Copyright © 2016 Taylor Benna. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let query = Donator.query()!
//     //   query.whereKey("username", equalTo: currentUser.username)
//        query.findObjectsInBackgroundWithBlock { [weak self] (objects, error) in
//            
//            if let donators = objects as? [Donator] {
////                self?.charities = charities
////                self?.tableView.reloadData()
//            }
//        }

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
}
