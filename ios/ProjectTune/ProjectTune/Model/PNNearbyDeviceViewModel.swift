//
//  PNNearbyListViewModel.swift
//  ProjectTune
//
//  Created by Michael Latman on 2/17/18.
//  Copyright © 2018 GroupTune. All rights reserved.
//

import Foundation

public class PNNearbyDeviceViewModel: PNViewModel {
    var deviceName: String? = nil
    var broadcastName: String? = nil
    
    init(deviceName: String, broadcastName: String){
        self.deviceName = deviceName
        self.broadcastName = broadcastName
    }
}
