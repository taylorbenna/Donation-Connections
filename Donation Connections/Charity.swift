//
//  Charity.swift
//  Donation Connections
//
//  Created by Taylor Benna on 2016-06-15.
//  Copyright © 2016 Taylor Benna. All rights reserved.
//

import UIKit
import Parse

class Charity: PFObject, PFSubclassing {

    @NSManaged var charityName:String
    @NSManaged var charityOwner:String
    @NSManaged var charityBio:String
    @NSManaged var charityItems:[String]
    @NSManaged var charityImage:NSData
    
    override class func initialize() {
        struct Static {
            static var onceToken : dispatch_once_t = 0;
        }
        dispatch_once(&Static.onceToken) {
            self.registerSubclass()
        }
    }
    
    static func parseClassName() -> String {
        return "Charity"
    }
    
}
