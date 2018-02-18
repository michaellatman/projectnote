//
//  PNDeviceNavigationViewController.swift
//  ProjectTune
//
//  Created by Michael Latman on 2/17/18.
//  Copyright © 2018 GroupTune. All rights reserved.
//

import UIKit
import LNPopupController
import Firebase
class PNDeviceNavigationViewController: PNNavigationViewController {
    var popupvc: PNMusicPlayerControlsViewController? = nil
    var listener: ListenerRegistration? = nil
    var db = Firestore.firestore()
    override func viewDidLoad() {
        super.viewDidLoad()
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        popupvc = storyboard.instantiateViewController(withIdentifier: "MusicPlayerControlsView") as! PNMusicPlayerControlsViewController
        
        self.popupInteractionStyle = .drag
        self.view.backgroundColor = UIColor.black
        self.presentPopupBar(withContentViewController: popupvc!, animated: true) {
            
        }

        listener = db.collection("broadcast").document("testing").addSnapshotListener { (snap, err) in
            if let isPl = snap!.get("isPlaying") as? Bool {
                if(isPl == true){
                      self.popupvc?.model.isPlaying = true
                }
                else{
                    self.popupvc?.model.isPlaying = false
                }
              
            }
            
            if let artist = snap!.get("artist") as? String {
                self.popupvc?.model.artistName = artist
            }
            
            if let song = snap!.get("songTitle") as? String {
                self.popupvc?.model.songName = song
            }
            
            if let songId = snap!.get("currentTrackID") as? String {
                self.popupvc?.model.trackId = songId
            }
            
            self.popupvc?.updateModel()
        }
        // Do any additional setup after loading the view.
    }
    
    func getModel() -> PNMusicViewModel {
        return popupvc!.model
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        listener?.remove()
        print("Bye!")
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
