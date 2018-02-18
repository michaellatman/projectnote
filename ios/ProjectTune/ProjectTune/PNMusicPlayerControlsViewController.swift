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
    
    var model = PNMusicViewModel.init(songName: "song", artistName: "artist", isPlaying: false)
    override func viewDidLoad() {
        super.viewDidLoad()
        
        artistNameLabel.text = model.artistName
        if(model.isPlaying == false){
            let pause = UIBarButtonItem(image: UIImage(named: "pause"), style: .plain, target: nil, action: nil)
            pause.accessibilityLabel = NSLocalizedString("Pause", comment: "")
            pause.tintColor = UIColor.white
            pause.tintColor = UIColor.white
            popupItem.leftBarButtonItems = [ pause ]
            
            let nowPlayingPause = UIBarButtonItem(image: UIImage(named: "pause"), style: .plain, target: nil, action: nil)
            nowPlayingPause.accessibilityLabel = NSLocalizedString("Pause", comment: "")
            nowPlayingPause.tintColor = UIColor.white
            nowPlayingPause.tintColor = UIColor.white
            popupItem.leftBarButtonItems = [ nowPlayingPause ]
        }
        else if (model.isPlaying == true){
            let play = UIBarButtonItem(image: UIImage(named: "play"), style: .plain, target: nil, action: nil)
            play.accessibilityLabel = NSLocalizedString("Play", comment: "")
            play.tintColor = UIColor.white
            play.tintColor = UIColor.white
            popupItem.leftBarButtonItems = [ play ]
            
            let nowPlayingPlay = UIBarButtonItem(image: UIImage(named: "play"), style: .plain, target: nil, action: nil)
            nowPlayingPlay.accessibilityLabel = NSLocalizedString("Play", comment: "")
            nowPlayingPlay.tintColor = UIColor.white
            nowPlayingPlay.tintColor = UIColor.white
            popupItem.leftBarButtonItems = [ nowPlayingPlay ]
        }
        
        let next = UIBarButtonItem(image: UIImage(named: "nextFwd"), style: .plain, target: nil, action: nil)
        next.accessibilityLabel = NSLocalizedString("Next Track", comment: "")
        next.tintColor = UIColor.white
    
        popupItem.title = model.songName
        popupItem.subtitle = model.artistName
        
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
