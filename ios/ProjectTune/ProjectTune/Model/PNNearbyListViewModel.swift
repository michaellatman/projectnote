//
//  PNNearbyListViewModel.swift
//  ProjectTune
//
//  Created by Michael Latman on 2/17/18.
//  Copyright © 2018 GroupTune. All rights reserved.
//

import Foundation

public class PNNearbyListViewModel: PNViewModel {
    var nearbyDevices: [PNNearbyDeviceViewModel] = []
    
    override init() {
        
    }
    
    init(devices: [PNNearbyDeviceViewModel]) {
        self.nearbyDevices = devices
    }
    
    func addDevice(_ device: PNNearbyDeviceViewModel) {
        self.nearbyDevices.append(device)
    }
    
}
