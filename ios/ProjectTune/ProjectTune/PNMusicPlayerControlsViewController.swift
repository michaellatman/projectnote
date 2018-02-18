//
//  PNMusicPlayerControlsViewController.swift
//  ProjectTune
//
//  Created by Michael Latman on 2/17/18.
//  Copyright © 2018 GroupTune. All rights reserved.
//

import UIKit
import LNPopupController

class PNMusicPlayerControlsViewController: UIViewController {
    @IBOutlet weak var artistNameLabel: UILabel!
    
    @IBOutlet weak var trackNameLabel: UIVisualEffectView!
    
    @IBOutlet weak var pausePlayButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let pause = UIBarButtonItem(image: UIImage(named: "pause"), style: .plain, target: nil, action: nil)
        pause.accessibilityLabel = NSLocalizedString("Pause", comment: "")
        pause.tintColor = UIColor.white
        let next = UIBarButtonItem(image: UIImage(named: "nextFwd"), style: .plain, target: nil, action: nil)
        next.accessibilityLabel = NSLocalizedString("Next Track", comment: "")
        next.tintColor = UIColor.white
        popupItem.title = "Party in The USA"
        popupItem.subtitle = "Miley Cyrus"
        popupItem.leftBarButtonItems = [ pause ]
        popupItem.rightBarButtonItems = [ next ]
        
        
        LNPopupBar.appearance().barTintColor = Colors.blueDark
        LNPopupBar.appearance().backgroundStyle = UIBlurEffectStyle.dark
        
        popupItem.progress += 0.5;
        // Do any additional setup after loading the view.
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
