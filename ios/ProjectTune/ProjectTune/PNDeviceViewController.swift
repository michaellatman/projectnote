//
//  PNDeviceViewController.swift
//  ProjectTune
//
//  Created by Michael Latman on 2/16/18.
//  Copyright © 2018 GroupTune. All rights reserved.
//

import UIKit
import LNPopupController
import CoreBluetooth
import CoreLocation
import MediaPlayer
import FirebaseFirestore
import PromiseKit

class PNDeviceViewController: UIViewController, CBPeripheralManagerDelegate, PNMusicPlaybackDelegate{

    private var musicPlayer : MPMusicPlayerApplicationController = MPMusicPlayerController.applicationQueuePlayer
    var localBeacon: CLBeaconRegion!
    var beaconPeripheralData: NSDictionary!
    var peripheralManager: CBPeripheralManager!
    
    var isHost = false
    let broadcastId = "testing"
    let broadcastName = "Demo"
    var queue: [PNTrack] = []
    var musicController: PNMusicController?
    var commandListener: ListenerRegistration? = nil
    var queueListener: ListenerRegistration? = nil
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func dismissPressed(_ sender: Any) {
        let db = Firestore.firestore()
        commandListener?.remove()
        queueListener?.remove()
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func addButtonPressed(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        if(isHost){
            
            NotificationCenter.default.addObserver(self, selector: #selector(onPlayingItemChanged), name: NSNotification.Name.MPMusicPlayerControllerNowPlayingItemDidChange, object: nil)
            
            NotificationCenter.default.addObserver(self, selector: #selector(onPlaybackStateChange), name: NSNotification.Name.MPMusicPlayerControllerPlaybackStateDidChange, object: nil)
            musicPlayer.beginGeneratingPlaybackNotifications()
            
            
            print("Host")
            let localBeaconUUID = "5A4BCFCE-174E-4BAC-A814-092E77F6B7E5"
            let localBeaconMajor: CLBeaconMajorValue = 123
            let localBeaconMinor: CLBeaconMinorValue = 456
            
            let uuid = UUID(uuidString: localBeaconUUID)!
            localBeacon = CLBeaconRegion(proximityUUID: uuid, major: localBeaconMajor, minor: localBeaconMinor, identifier: "Your private identifer here")
            
            beaconPeripheralData = localBeacon.peripheralData(withMeasuredPower: nil)
            peripheralManager = CBPeripheralManager(delegate: self, queue: nil, options: nil)
            
     
            let db = Firestore.firestore()
            
            commandListener = db.collection("broadcast").document(broadcastId).addSnapshotListener { (snap, err) in
                var command = (snap!.get("remote_action") as! String).components(separatedBy: "|")
                db.collection("broadcast").document(self.broadcastId).updateData(["remote_action": ""])
                print(command)
                if(command[0] == "alexa"){
                    if(command[1] == "song"){
                        firstly {
                            PNNetwork.fetchTracksWith(term: command[2])
                            }.done { response in
                                print(response.results?.first)
                                DispatchQueue.main.async {
                                    PNFirebase.add(track: response.results!.first!, broadcastId: "testing")
                                }
                                
                               
                               
                                
                            }.catch { error in
                                //…
                                print(error)
                        }
                    }
                    else if(command[1] == "skip"){
                        self.musicPlayer.skipToNextItem()
                    }
                    else if(command[1] == "pause"){
                        self.musicPlayer.pause()
                          db.collection("broadcast").document(self.broadcastId).updateData(["isPlaying": false])
                    }
                    else if(command[1] == "toggle"){
                        if(self.musicPlayer.playbackState == .playing){
                             self.musicPlayer.pause()
                              db.collection("broadcast").document(self.broadcastId).updateData(["isPlaying": false])
                        }
                        else{
                             self.musicPlayer.play()
                            db.collection("broadcast").document(self.broadcastId).updateData(["isPlaying": true])
                            
                        }
                    }
                    else if(command[1] == "play"){
                        self.musicPlayer.play()
                        db.collection("broadcast").document(self.broadcastId).updateData(["isPlaying": true])
                    }
                    else if(command[1] == "previous"){
                        self.musicPlayer.skipToPreviousItem()
                    }
                    else if(command[1] == "restart"){
                        self.musicPlayer.skipToBeginning()
                    }
                    
                  
                }
            }
            

            var first = true
            queueListener = db.collection("broadcast").document(broadcastId).collection("queue").addSnapshotListener { (snap, err) in
                snap!.documentChanges.reversed().forEach { diff in
                    if (diff.type == .added) {
                        var track = PNTrack.init(dictionary: diff.document.data())
                        print("Added")
                        DispatchQueue.main.async {
                            let newQueueDescriptor = MPMusicPlayerStoreQueueDescriptor.init(storeIDs: ["\(track.trackId!)"])
                            
                            if(first == true){
                                self.musicPlayer.setQueue(with: newQueueDescriptor)
                                first = false
                                self.musicPlayer.play()
                    
                                
                            }
                            else{
                                self.musicPlayer.append(newQueueDescriptor)
                            }
                            self.queue.append(track)
                            
                            self.tableView.reloadData()
                        }
                        
                        
                        
                    }
                    if (diff.type == .modified) {
                        print("Modified city: \(diff.document.data())")
                    }
                    if (diff.type == .removed) {
                        print("Removed city: \(diff.document.data())")
                    }
                }
                
            }
        

            
        } else {
            
            let db = Firestore.firestore()
            let queuedCollection = db.collection("broadcast").document(broadcastId).collection("queue").addSnapshotListener { (snap, err) in
                snap!.documentChanges.reversed().forEach { diff in
                    if (diff.type == .added) {
                        var track = PNTrack.init(dictionary: diff.document.data())
                        self.queue.append(track)
                        
                        self.tableView.reloadData()
                        
                        
                    }
                    if (diff.type == .modified) {
                        print("Modified city: \(diff.document.data())")
                    }
                    if (diff.type == .removed) {
                        print("Removed city: \(diff.document.data())")
                    }
                }
                
            }
        }
        
       
    
        
       

       
        
        /*PNFirebase.getQueue(broadcastId: broadcastId, completion: { (trackList, error) in
            if error == nil {
                //self.musicController?.updateQueue(newQueue: trackList!)
                self.queue = trackList!
                self.musicController!.addSong(newSong: trackList!.first!)
                self.tableView.reloadData()
            } else {
                print("Could not get items")
                print(error ?? "error")
            }
        })*/
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        stopLocalBeacon()
    }
    
    func stopLocalBeacon() {
        if(peripheralManager != nil) {
            peripheralManager.stopAdvertising()
            peripheralManager = nil
            beaconPeripheralData = nil
            localBeacon = nil
        }
    }
    
    
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        if peripheral.state == .poweredOn {
            peripheralManager.startAdvertising(beaconPeripheralData as! [String: AnyObject]!)
        } else if peripheral.state == .poweredOff {
            peripheralManager.stopAdvertising()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func onSkipPrevious() {
        if (isHost){
            
        } else {
            
        }
    }
    
    func onSkipNext() {
        if (isHost){
            
        } else {
            
        }
    }
    
    func onPlay() {
        if (isHost){
            
        } else {
            
        }
    }
    
    func onPause() {
        if (isHost){
            
        } else {
            
        }
    }
    
    func onStop() {
        if (isHost){
            
        } else {
            
        }
    }
    
    func onPlayIndex(_ index: Int) {
        if (isHost){
            
        } else {
            
        }
    }
    @objc func onPlaybackStateChange(playingItem: MPMediaItem?) {
     
            print("Playing state change")
        
        
                var isPlaying = false
                let db = Firestore.firestore()
                if(playingItem != nil) {
                    isPlaying = true
                }
                else {
                    isPlaying = false
                }
        
        
    }
    @objc func onPlayingItemChanged(playingItem: MPMediaItem?) {
        var pp = self.musicPlayer.nowPlayingItem
        if(pp != nil){
        
        let db = Firestore.firestore()
        if(pp != nil){
                
            db.collection("broadcast").document(self.broadcastId).updateData(["currentTrackID": pp!.playbackStoreID,
                "artist": "\(pp!.artist!)", "songTitle": "\(pp!.title!)", "currentTrackDescription": "\(pp!.title!) by \(pp!.artist!)"])
        }
            }
        
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

extension PNDeviceViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return queue.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PNSongTableViewCell = tableView.dequeueReusableCell(withIdentifier: "songCell")! as! PNSongTableViewCell
        cell.trackArtist.text = queue[indexPath.row].artistName
        cell.trackTitle.text = queue[indexPath.row].trackName
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Upcoming"
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let hv = view as! UITableViewHeaderFooterView
        hv.textLabel?.textColor = UIColor.white
        hv.tintColor = Colors.secondaryDarkColor.lighten(byPercentage: 0.1)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if (isHost){
            //musicController!.playIndex(index: indexPath.row)
            //print(indexPath.row)
        } else {
            //PNRemoteAction.init(broadcastId: broadcastId).send
        }
        

    }
}



