//
//  PNMusicController.swift
//  ProjectTune
//
//  Created by Arnold Balliu on 2/16/18.
//  Copyright © 2018 GroupTune. All rights reserved.
//

import Foundation
import MediaPlayer

class PNMusicController {
    
    private var internalTrackList: [PNTrack] = []
    private var musicPlayer : MPMusicPlayerApplicationController
    private var queueDescriptor: MPMusicPlayerStoreQueueDescriptor
    
    init(withTracks: [PNTrack]) {
        internalTrackList = withTracks
        var internalTrackIdList: [String] = []
        for track in internalTrackList {
            internalTrackIdList.append(track.id)
        }
        queueDescriptor = MPMusicPlayerStoreQueueDescriptor.init(storeIDs: internalTrackIdList)
        musicPlayer = MPMusicPlayerController.applicationQueuePlayer
        musicPlayer.setQueue(with: queueDescriptor)
        musicPlayer.prepareToPlay()
    }
    
    func pause() -> Void {
        if musicPlayer.playbackState == .playing {
            musicPlayer.pause()
        }
    }
    
    func play() -> Void {
        if musicPlayer.playbackState == .playing || musicPlayer.playbackState == .stopped {
            musicPlayer.play()
        }
    }
    
    func stop() {
        if musicPlayer.playbackState == .playing || musicPlayer.playbackState == .paused {
            musicPlayer.stop()
        }
    }
    
    func skipNext() -> Void {
        musicPlayer.skipToNextItem()
    }
    
    
    func skipPrevious() -> Void {
        musicPlayer.skipToPreviousItem()
    }
    
    func add(track: PNTrack, onAddFinished onAdd: @escaping ([PNTrack]) -> Void) {
//        let newQueueDescriptor: MPMusicPlayerStoreQueueDescriptor = MPMusicPlayerStoreQueueDescriptor.init(storeIDs: [track.id])
//        musicPlayer.append(newQueueDescriptor)
        musicPlayer.perform(queueTransaction: { (mutableQueue) in
            let newQueueDescriptor: MPMusicPlayerStoreQueueDescriptor = MPMusicPlayerStoreQueueDescriptor.init(storeIDs: [track.id])
            let queueItems = mutableQueue.items
            mutableQueue.insert(newQueueDescriptor, after: queueItems[queueItems.count-1])
        }) { (queue, error) in
            onAdd(self.internalTrackList)
        }
    }
    
    func remove(track: PNTrack, onRemoveFinished onRemove: @escaping ([PNTrack]) -> Void) {
        musicPlayer.perform(queueTransaction: { (mutableQueue) in
            let queueItems = mutableQueue.items
            for index in 0..<queueItems.count {
                let item = queueItems[index]
                if item.playbackStoreID == track.id && index != 0 {
                    mutableQueue.remove(item)
                    self.internalTrackList.remove(at: index)
                }
            }
        }) { (queue, error) in
            onRemove(self.internalTrackList)
        }
    }
}
