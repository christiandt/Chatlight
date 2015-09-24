//
//  MessageTableViewCell.swift
//  ParseStarterProject-Swift
//
//  Created by Christian Dancke Tuen on 11/09/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit

class MessageTableViewCell: UITableViewCell {

    @IBOutlet weak var senderLabel: UILabel!
    @IBOutlet weak var textPreviewLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
