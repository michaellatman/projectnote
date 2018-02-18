//
//  PNDeviceNavigationViewController.swift
//  ProjectTune
//
//  Created by Michael Latman on 2/17/18.
//  Copyright © 2018 GroupTune. All rights reserved.
//

import UIKit
import LNPopupController

class PNDeviceNavigationViewController: PNNavigationViewController {
    var popupvc: PNMusicPlayerControlsViewController? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        popupvc = storyboard.instantiateViewController(withIdentifier: "MusicPlayerControlsView") as! PNMusicPlayerControlsViewController
        
        self.popupInteractionStyle = .drag
        self.view.backgroundColor = UIColor.black
        self.presentPopupBar(withContentViewController: popupvc!, animated: true) {
            
        }
        // Do any additional setup after loading the view.
    }
    
    func getModel() -> PNMusicViewModel {
        return popupvc!.model
    }
    
    func updateMode() {
        popupvc?.updateModel()
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
