//
//  CharityProfileView.swift
//  Donation Connections
//
//  Created by Taylor Benna on 2016-06-17.
//  Copyright © 2016 Taylor Benna. All rights reserved.
//

import UIKit

class CharityProfileView: UIView, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet var view: UIView!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var charityName: UILabel!
    @IBOutlet weak var bioTextView: UITextView!
    @IBOutlet weak var tableView: UITableView!
    
    var currentUser:Charity?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        NSBundle.mainBundle().loadNibNamed("CharityProfile", owner: self, options: nil)[0] as! UIView
        self.addSubview(view)
        view.frame = self.bounds
        
        tableView.registerNib(UINib(nibName: "ItemCellXib", bundle:nil), forCellReuseIdentifier: "itemCell")
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        NSBundle.mainBundle().loadNibNamed("CharityProfile", owner: self, options: nil)[0] as! UIView
        self.addSubview(view)
        view.frame = self.bounds
        
        tableView.registerNib(UINib(nibName: "ItemCellXib", bundle:nil), forCellReuseIdentifier: "itemCell")
        
    }
    
    override func didMoveToSuperview() {
        showDetails()
    }
    
    func showDetails() {
        
        currentUser!.charityImage.getDataInBackgroundWithBlock({ (data, error) in
            guard let data = data else { return }
            self.imageView.image = UIImage(data: data)
        })

        charityName.text = currentUser?.charityName
        bioTextView.text = currentUser?.charityBio
        
        
    }
    
    //MARK: Table View
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (currentUser?.charityItems.count)!
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("itemCell", forIndexPath: indexPath) as! ItemTableViewCell
        cell.itemLabel.text = currentUser?.charityItems[indexPath.row]
        return cell
    }
    
    
}
