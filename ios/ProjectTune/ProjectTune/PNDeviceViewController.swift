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

class PNDeviceViewController: UIViewController {
    
    var isHost = false
    let broadcastId = "testing"
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func dismissPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(isHost){
            
            print("Host")
            let proximityUUID = UUID(uuidString:
                "39ED98FF-2900-441A-802F-9C398FC199D2")
            let major : CLBeaconMajorValue = 100
            let minor : CLBeaconMinorValue = 1
            let beaconID = "com.example.myDeviceRegion"
            
            let peripheral = CBPeripheralManager(delegate: nil, queue: nil)
            let peripheralData = CLBeaconRegion(proximityUUID: proximityUUID!,
                                                major: major, minor: minor, identifier: beaconID).peripheralData(withMeasuredPower: nil)
            
            peripheral.startAdvertising(((peripheralData as NSDictionary) as! [String : Any]))
        }
        
        
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

extension PNDeviceViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PNSongTableViewCell = tableView.dequeueReusableCell(withIdentifier: "songCell")! as! PNSongTableViewCell
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
}



