//
//  PNNearbyCardTableViewCell.swift
//  ProjectTune
//
//  Created by Michael Latman on 2/16/18.
//  Copyright © 2018 GroupTune. All rights reserved.
//

import UIKit

class PNNearbyCardTableViewCell: PNCustomTableViewCell {
    override func awakeFromNib() {
        selectableView.backgroundColor = Colors.blue
        super.awakeFromNib()
    }
    @IBOutlet weak var broadcastNameLabel: UILabel!
    @IBOutlet weak var deviceNameLabel: UILabel!
    
    override func setViewModel(_ model: PNViewModel) {
        if let model = model as? PNNearbyDeviceViewModel {
            broadcastNameLabel.text = model.broadcastName
            
                deviceNameLabel.text = model.deviceName
        }
    }
}
