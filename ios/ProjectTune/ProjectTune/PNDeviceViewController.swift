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

class PNDeviceViewController: UIViewController, CBPeripheralManagerDelegate, PNMusicPlaybackDelegate{

    var localBeacon: CLBeaconRegion!
    var beaconPeripheralData: NSDictionary!
    var peripheralManager: CBPeripheralManager!
    var musicControllerDelegate: PNMusicControllerProtocol?
    
    var isHost = false
    let broadcastId = "testing"
    let broadcastName = "Demo"
    var queue: [PNTrack] = []
    var musicController: PNMusicController?
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func dismissPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func addButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(isHost){
            
            print("Host")
            let localBeaconUUID = "5A4BCFCE-174E-4BAC-A814-092E77F6B7E5"
            let localBeaconMajor: CLBeaconMajorValue = 123
            let localBeaconMinor: CLBeaconMinorValue = 456
            
            let uuid = UUID(uuidString: localBeaconUUID)!
            localBeacon = CLBeaconRegion(proximityUUID: uuid, major: localBeaconMajor, minor: localBeaconMinor, identifier: "Your private identifer here")
            
            beaconPeripheralData = localBeacon.peripheralData(withMeasuredPower: nil)
            peripheralManager = CBPeripheralManager(delegate: self, queue: nil, options: nil)
            
            musicController = PNMusicController.init(withTracks: [], delegate: self)
            musicControllerDelegate = musicController
            
        } else {
        
            //if not host listen for changes to the queue
            PNFirebase.getQueue(broadcastId: broadcastId, completion: { (trackList, error) in
                if error == nil {
                    self.queue = trackList!
                    self.tableView.reloadData()
                } else {
                    print("Could not get items")
                    print(error ?? "error")
                }
            })
            
        }
        
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
            if musicControllerDelegate != nil {
                musicControllerDelegate?.playIndex(index: indexPath.row)
            }
        } else {
            //PNRemoteAction.init(broadcastId: broadcastId).send
        }
        

    }
}



