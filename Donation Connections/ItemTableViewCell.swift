//
//  ItemTableViewCell.swift
//  Donation Connections
//
//  Created by Taylor Benna on 2016-06-15.
//  Copyright © 2016 Taylor Benna. All rights reserved.
//

import UIKit

class ItemTableViewCell: UITableViewCell {

    
    @IBOutlet weak var itemLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
