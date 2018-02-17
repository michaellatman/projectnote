//
//  PNNearbyCardTableViewCell.swift
//  ProjectTune
//
//  Created by Michael Latman on 2/16/18.
//  Copyright © 2018 GroupTune. All rights reserved.
//

import UIKit

class PNNearbyCardTableViewCell: UITableViewCell {

    @IBOutlet weak var customView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        customView.backgroundColor = Colors.blue
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
        
        // Configure the view for the selected state
    }

}
