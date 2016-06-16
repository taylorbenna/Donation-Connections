//
//  CharityDetailView.swift
//  Donation Connections
//
//  Created by Taylor Benna on 2016-06-13.
//  Copyright © 2016 Taylor Benna. All rights reserved.
//

import UIKit

class CharityDetailView: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    var currentCharity:Charity?
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var charityNameLabel: UILabel!
    @IBOutlet weak var charityBioTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        currentCharity!.charityImage.getDataInBackgroundWithBlock({ (data, error) in
            guard let data = data else { return }
            self.imageView.image = UIImage(data: data)
        })
        
        charityNameLabel.text = currentCharity!.charityName
        charityBioTextView.text = currentCharity!.charityBio
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backButtonPressed(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    //MARK: Collection View
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (currentCharity?.charityItems.count)!
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("itemCollectionCell", forIndexPath: indexPath) as! ItemCollectionViewCell
        
        cell.itemLabel.text = currentCharity?.charityItems[indexPath.row]
        
        return cell
    }
}
