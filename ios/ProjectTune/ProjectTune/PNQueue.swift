//
//  PNQueue.swift
//  ProjectTune
//
//  Created by Arnold Balliu on 2/17/18.
//  Copyright © 2018 GroupTune. All rights reserved.
//

import Foundation

struct PNQueue: Codable {
    let trackCount : Int?
    let tracks : [PNTrack]?
    
    enum CodingKeys: String, CodingKey {
        
        case trackCount = "trackCount"
        case tracks = "tracks"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        trackCount = try values.decodeIfPresent(Int.self, forKey: .trackCount)
        tracks = try values.decodeIfPresent([PNTrack].self, forKey: .tracks)
    }
}
