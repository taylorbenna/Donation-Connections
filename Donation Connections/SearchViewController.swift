//
//  SearchViewController.swift
//  Donation Connections
//
//  Created by Taylor Benna on 2016-06-15.
//  Copyright © 2016 Taylor Benna. All rights reserved.
//

import UIKit
import Parse

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    var charities:[Charity] = []
    var searchedCharities:[Charity] = []
    var currentCharity:Charity?
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var charitySearchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        charitySearchBar.showsCancelButton = true
        charitySearchBar.delegate = self
    
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        let defaults = NSUserDefaults.standardUserDefaults()
        if (defaults.objectForKey("user") == nil) {
            performSegueWithIdentifier("showSignUp", sender: self)
        } else {
            getCharities()
        }
    }
    
    func getCharities() {
        let query = Charity.query()!
        query.findObjectsInBackgroundWithBlock { [weak self] (objects, error) in
            
            if let charities = objects as? [Charity] {
                self?.charities = charities
                self?.searchedCharities = charities
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
        return searchedCharities.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("charityCell", forIndexPath: indexPath) as! CharityTableViewCell
        
        let charity = searchedCharities[indexPath.row]
        
        cell.charityNameLabel.text = charity.charityName
        let items = charity.charityItems.joinWithSeparator(", ")
        cell.itemsLabel.text = items
        
        charity.charityImage.getDataInBackgroundWithBlock({ (data, error) in
            guard let data = data else { return }
            cell.charityImageView.image = UIImage(data: data)
        })
        
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        currentCharity = searchedCharities[indexPath.row]
        performSegueWithIdentifier("detailSegue", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "detailSegue" {
            let dViewController = segue.destinationViewController as! CharityDetailView
            dViewController.currentCharity = currentCharity
        } else if segue.identifier == "showSignUp" {
            
        }
    }
    
    //MARK: Search Bar
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.endEditing(true)
        searchedCharities = charities
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchBar.endEditing(true)
        
        let searchString = searchBar.text
        
        searchedCharities = []
        
        for char in charities {
            for charItem in char.charityItems {
                let item = charItem.lowercaseString
                if item.containsString((searchString?.lowercaseString)!) {
                    searchedCharities.append(char)
                    break
                }
            }
        }
        
        
        tableView.reloadData()
    }

}
