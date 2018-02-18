//
//  PNMusicPlayerControlsViewController.swift
//  ProjectTune
//
//  Created by Michael Latman on 2/17/18.
//  Copyright © 2018 GroupTune. All rights reserved.
//

import UIKit
import LNPopupController
import Firebase
import PromiseKit
import SDWebImage

class PNMusicPlayerControlsViewController: UIViewController {
    @IBOutlet weak var artistNameLabel: UILabel!
    
    @IBOutlet weak var trackNameLabel: UILabel!
    
    @IBOutlet weak var pausePlayButton: UIButton!
<<<<<<< HEAD
    var db = Firestore.firestore()
    var model = PNMusicViewModel.init(songName: "song", artistName: "artist", isPlaying: true, trackId: nil)
=======

>>>>>>> 797b8a7dbf562e7459eb89099fabd8387f129d25
    
    @IBOutlet weak var backgroundAlbumImageView: UIImageView!
    @IBOutlet weak var foregroundAlbumImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateModel()
    }
    
    @IBAction func skipPrevious(_ sender: Any) {
    db.collection("broadcast").document("testing").updateData(["remote_action":"alexa|previous"])
    }
    @IBAction func playbackToggle(_ sender: Any) {
        db.collection("broadcast").document("testing").updateData(["remote_action":"alexa|toggle"])
    }
    
    
    @IBAction func skipForward(_ sender: Any) {
        db.collection("broadcast").document("testing").updateData(["remote_action":"alexa|skip"])
    }
    
    func updateModel(){
        
      
        artistNameLabel.text = model.artistName
<<<<<<< HEAD
        trackNameLabel.text = model.songName
        if(model.isPlaying == true){
              print("dawdwd")
            let pause = UIBarButtonItem(image: UIImage(named: "pause"), style: .plain, target: self, action: #selector(playbackToggle))
=======
        if(model.isPlaying == true){
            let pause = UIBarButtonItem(image: UIImage(named: "pause"), style: .plain, target: nil, action: nil)
>>>>>>> 797b8a7dbf562e7459eb89099fabd8387f129d25
            pause.accessibilityLabel = NSLocalizedString("Pause", comment: "")
            pause.tintColor = UIColor.white
            pause.tintColor = UIColor.white
            
<<<<<<< HEAD
            
            popupItem.leftBarButtonItems = [ pause ]
        
            pausePlayButton.imageView!.image = UIImage(named: "nowPlaying_pause")!
        }
        else if (model.isPlaying == false     ){
            let play = UIBarButtonItem(image: UIImage(named: "play"), style: .plain, target: self, action: #selector(playbackToggle))
=======
            pausePlayButton.imageView?.image =
                UIImage(named: "nowPlaying_pause")

        }
        else if (model.isPlaying == false){
            let play = UIBarButtonItem(image: UIImage(named: "play"), style: .plain, target: nil, action: nil)
>>>>>>> 797b8a7dbf562e7459eb89099fabd8387f129d25
            play.accessibilityLabel = NSLocalizedString("Play", comment: "")
            play.tintColor = UIColor.white
            play.tintColor = UIColor.white
            popupItem.leftBarButtonItems = [ play ]
            
<<<<<<< HEAD
            pausePlayButton.imageView!.image = UIImage(named: "nowPlaying_play")!
=======
            pausePlayButton.imageView?.image =
                UIImage(named: "nowPlaying_play")
        
>>>>>>> 797b8a7dbf562e7459eb89099fabd8387f129d25
        }
        
        let next = UIBarButtonItem(image: UIImage(named: "nextFwd"), style: .plain, target: self, action: #selector(skipForward))
        next.accessibilityLabel = NSLocalizedString("Next Track", comment: "")
        next.tintColor = UIColor.white
        
        popupItem.title = model.songName
        popupItem.subtitle = model.artistName
        
        popupItem.rightBarButtonItems = [ next ]
        
        
        LNPopupBar.appearance().barTintColor = Colors.blueDark
        LNPopupBar.appearance().backgroundStyle = UIBlurEffectStyle.dark
        
        popupItem.progress += 0.5;
        if(self.model.trackId != nil){
            firstly {
                PNNetwork.fetchTracksWith(term: self.model.trackId!)
                }.done { response in
                    var fi = response.results?.first
                    if(fi != nil){
                        var final = fi!.artworkUrl100!.replacingOccurrences(of: "100x100bb.jpg", with: "600x600.jpg")
                        print(final)
                        self.foregroundAlbumImageView.sd_setImage(with: URL.init(string: final)!) { (image, err, cache, url) in
                            
                        }
                        
                        self.backgroundAlbumImageView.sd_setImage(with: URL.init(string: final)!) { (image, err, cache, url) in
                            
                        }
                    }
                    
                }.catch { error in
                    //…
                    print(error)
            }
        }
       
        /**/
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
