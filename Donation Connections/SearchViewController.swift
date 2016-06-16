//
//  SearchViewController.swift
//  Donation Connections
//
//  Created by Taylor Benna on 2016-06-15.
//  Copyright © 2016 Taylor Benna. All rights reserved.
//

import UIKit
import Parse

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var charities:[Charity] = []
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let query = Charity.query()!
        query.findObjectsInBackgroundWithBlock { [weak self] (objects, error) in
            
            if let charities = objects as? [Charity] {
                self?.charities = charities
                self?.tableView.reloadData()
            }
        }
        
        
        

        
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
   //MARK: Table View
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return charities.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("charityCell", forIndexPath: indexPath) as! CharityTableViewCell
        
        let charity = charities[indexPath.row]
        
        cell.charityNameLabel.text = charity.charityName
        let items = charity.charityItems.joinWithSeparator(", ")
        cell.itemsLabel.text = items
        cell.charityImageView.image = UIImage(data:charity.charityImage, scale:1.0)
        
        
        return cell
    }

}
