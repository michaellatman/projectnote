//
//  PNNearbyListViewModel.swift
//  ProjectTune
//
//  Created by Michael Latman on 2/17/18.
//  Copyright © 2018 GroupTune. All rights reserved.
//

import Foundation

public class PNSearchResultViewModel: PNViewModel {
    var tracks: [PNTrack]? = nil
    
    init(tracks: [PNTrack]){
        self.tracks = tracks
    }
}
