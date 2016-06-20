//
//  EditCharityViewController.swift
//  Donation Connections
//
//  Created by Taylor Benna on 2016-06-20.
//  Copyright © 2016 Taylor Benna. All rights reserved.
//

import UIKit

class EditCharityViewController: UIViewController {
    
    var currentCharity:Charity!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Buttons
    
    @IBAction func cancelButtonPressed(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func saveButtonPressed(sender: UIButton) {
        
    }
    
}
