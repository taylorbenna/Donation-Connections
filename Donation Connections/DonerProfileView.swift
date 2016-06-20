//
//  DonerProfileView.swift
//  Donation Connections
//
//  Created by Taylor Benna on 2016-06-17.
//  Copyright © 2016 Taylor Benna. All rights reserved.
//

import UIKit

class DonerProfileView: UIView {

    
    @IBOutlet var view: UIView!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    
    var currentUser:Donator!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        NSBundle.mainBundle().loadNibNamed("DonerProfile", owner: self, options: nil)[0] as! UIView
        self.addSubview(view)
        view.frame = self.bounds
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        NSBundle.mainBundle().loadNibNamed("DonerProfile", owner: self, options: nil)[0] as! UIView
        self.addSubview(view)
        view.frame = self.bounds
        
        
    }
    
    override func didMoveToSuperview() {
        showDetails()
    }
    
    func showDetails() {
        
        currentUser!.photo.getDataInBackgroundWithBlock({ (data, error) in
            guard let data = data else { return }
            self.imageView.image = UIImage(data: data)
        })
        
        firstNameLabel.text = currentUser.firstName
        lastNameLabel.text = currentUser.lastName
        
        
    }
    
    
}
