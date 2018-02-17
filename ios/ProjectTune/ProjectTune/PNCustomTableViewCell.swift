//
//  PNCustomTableViewCell.swift
//  ProjectTune
//
//  Created by Michael Latman on 2/17/18.
//  Copyright © 2018 GroupTune. All rights reserved.
//

import UIKit

class PNCustomTableViewCell: UITableViewCell {
    var originalColor: UIColor? = nil
    @IBOutlet weak var selectableView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if(self.selectableView == nil){
            self.selectableView = self.contentView
        }
        originalColor = self.selectableView.backgroundColor!
        // Initialization code
    }

   
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if(selected) {
            UIView.animate(withDuration: 0.1, delay: 0.0, options: .curveEaseOut, animations: {
                self.selectableView.backgroundColor = self.originalColor?.lighten(byPercentage: 0.1)
            }, completion: { finished in
                let when = DispatchTime.now() + 0.05 // change 2 to desired number of seconds
                DispatchQueue.main.asyncAfter(deadline: when) {
                    self.setSelected(false, animated: true)
                    // Your code with delay
                }
            })
            
        }
        else{
            UIView.animate(withDuration: 0.1, delay: 0.0, options: .curveEaseOut, animations: {
                self.selectableView.backgroundColor = self.originalColor
            }, completion: { finished in
                
            })
            
        }
    }
    
    func setViewModel(_ model: PNViewModel) {
        
    }

}
