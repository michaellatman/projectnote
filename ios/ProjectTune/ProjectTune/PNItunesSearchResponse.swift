//
//  PNItunesSearchResponse.swift
//  ProjectTune
//
//  Created by Arnold Balliu on 2/17/18.
//  Copyright © 2018 GroupTune. All rights reserved.
//

import Foundation

struct PNNetworkItunesSearchResponse : Codable {
    let resultCount : Int?
    let results : [PNTrack]?
    
    enum CodingKeys: String, CodingKey {
        
        case resultCount = "resultCount"
        case results = "results"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        resultCount = try values.decodeIfPresent(Int.self, forKey: .resultCount)
        results = try values.decodeIfPresent([PNTrack].self, forKey: .results)
    }
    
}
