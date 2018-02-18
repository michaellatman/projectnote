//
//  PNMusicViewModel.swift
//  ProjectTune
//
//  Created by Rebecca Martino on 2/17/18.
//  Copyright © 2018 GroupTune. All rights reserved.
//

import Foundation

public class PNMusicViewModel: PNViewModel {
    var songName: String? = nil
    var artistName: String? = nil
    var isPlaying: Bool = false
    var trackId: String? = nil
    init(songName: String, artistName: String, isPlaying: Bool, trackId: String?){
        self.songName = songName
        self.artistName = artistName
        self.isPlaying = isPlaying
        self.trackId = trackId
    }
}
