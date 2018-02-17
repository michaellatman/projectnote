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
    
    init(songName: String, artistName: String, isPlaying: Bool){
        self.songName = songName
        self.artistName = artistName
        self.isPlaying = isPlaying
    }
}
