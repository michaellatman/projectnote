//
//  PNPlaybackDelegate.swift
//  ProjectTune
//
//  Created by Arnold Balliu on 2/16/18.
//  Copyright © 2018 GroupTune. All rights reserved.
//

import Foundation
import MediaPlayer

protocol PNMusicPlaybackDelegate {
    
    func onSkipPrevious()
    func onSkipNext()
    func onPlay()
    func onPause()
    func onStop()
    func onPlayIndex(_ index: Int)
    func onPlayingItemChanged(playingItem: MPMediaItem?)
    
}
