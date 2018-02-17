//
//  PNTrack.swift
//  ProjectTune
//
//  Created by Arnold Balliu on 2/16/18.
//  Copyright © 2018 GroupTune. All rights reserved.
//

import Foundation

class PNTrack {
    
    var id: String = ""
    var name: String = ""
    var artist: String = ""
    var album: String = ""
    
    static func with() -> PNTrack {
        return PNTrack.init()
    }
    
    func id(_ id : String) -> PNTrack {
        self.id = id
        return self
    }
    
    func name(_ name: String) -> PNTrack {
        self.name = name
        return self
    }
    
    func artist(_ artist : String) -> PNTrack {
        self.artist = artist
        return self
    }
    
    func album(_ album: String) -> PNTrack {
        self.album = album
        return self
    }
}
