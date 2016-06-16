//
//  Donator.swift
//  Donation Connections
//
//  Created by Taylor Benna on 2016-06-15.
//  Copyright © 2016 Taylor Benna. All rights reserved.
//

import UIKit
import Parse

class Donator: PFObject, PFSubclassing{

    @NSManaged var firstName:String
    @NSManaged var lastName:String
    @NSManaged var username:String
    @NSManaged var photo:PFFile
    
    
    override class func initialize() {
        struct Static {
            static var onceToken : dispatch_once_t = 0;
        }
        dispatch_once(&Static.onceToken) {
            self.registerSubclass()
        }
    }
    
    static func parseClassName() -> String {
        return "Donator"
    }

    
}
