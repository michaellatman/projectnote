//
//  PNBroadcast.swift
//  ProjectTune
//
//  Created by Arnold Balliu on 2/17/18.
//  Copyright © 2018 GroupTune. All rights reserved.
//

import Foundation

class PNBroadcast: Codable {
    
    let broadcastId : String?
    let deviceName : String?
    let broadcastName : String?
    
    enum CodingKeys: String, CodingKey {
        case broadcastId = "broadcastId"
        case deviceName = "deviceName"
        case broadcastName = "broadcastName"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        broadcastId = try values.decodeIfPresent(String.self, forKey: .broadcastId)
        deviceName = try values.decodeIfPresent(String.self, forKey: .deviceName)
        broadcastName = try values.decodeIfPresent(String.self, forKey: .broadcastName)
    }
    
    init(_ broadcastId: String, _ broadcastName: String, _ deviceName: String){
        self.broadcastId = broadcastId
        self.broadcastName = broadcastName
        self.deviceName = deviceName
    }
    
}
