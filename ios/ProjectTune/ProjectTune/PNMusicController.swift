//
//  PNMusicController.swift
//  ProjectTune
//
//  Created by Arnold Balliu on 2/16/18.
//  Copyright © 2018 GroupTune. All rights reserved.
//

import Foundation
import MediaPlayer

class PNMusicController: PNMusicControllerProtocol {
    
    private var internalTrackList: [PNTrack] = []
    private var musicPlayer : MPMusicPlayerApplicationController
    private var queueDescriptor: MPMusicPlayerStoreQueueDescriptor
    private var musicPlaybackDelegate: PNMusicPlaybackDelegate

    
    init(withTracks: [PNTrack], delegate: PNMusicPlaybackDelegate) {
        internalTrackList = withTracks
        var internalTrackIdList: [String] = []
        for track in internalTrackList {
            internalTrackIdList.append("\(track.trackId ?? 0)")
        }
        queueDescriptor = MPMusicPlayerStoreQueueDescriptor.init(storeIDs: internalTrackIdList)
        musicPlayer = MPMusicPlayerController.applicationQueuePlayer
        musicPlayer.setQueue(with: queueDescriptor)
        musicPlayer.prepareToPlay()
        musicPlaybackDelegate = delegate
    }
    
    func pause() -> Void {
        if musicPlayer.playbackState == .playing {
            musicPlayer.pause()
            musicPlaybackDelegate.onPause()
        }
    }
    
    func playIndex(index: Int){
        if index < internalTrackList.count {
            musicPlayer.perform(queueTransaction: { (mutableQueue) in
                let mediaItems = mutableQueue.items
                let itemToPlay = mediaItems[index]
                self.musicPlayer.nowPlayingItem = itemToPlay
                self.musicPlaybackDelegate.onPlayIndex(index)
            }, completionHandler: { (queue, error) in
                
            })
        }
        
    }
    
    func play() -> Void {
        if musicPlayer.playbackState == .playing || musicPlayer.playbackState == .stopped {
            musicPlayer.play()
            musicPlaybackDelegate.onPlay()
        }
    }
    
    func stop() {
        if musicPlayer.playbackState == .playing || musicPlayer.playbackState == .paused {
            musicPlayer.stop()
            musicPlaybackDelegate.onStop()
        }
    }
    
    func skipNext() -> Void {
        musicPlayer.skipToNextItem()
        musicPlaybackDelegate.onSkipNext()
    }
    
    
    func skipPrevious() -> Void {
        musicPlayer.skipToPreviousItem()
        musicPlaybackDelegate.onSkipPrevious()
    }
    
    func add(track: PNTrack, onAddFinished onAdd: @escaping ([PNTrack]) -> Void) {
//        let newQueueDescriptor: MPMusicPlayerStoreQueueDescriptor = MPMusicPlayerStoreQueueDescriptor.init(storeIDs: [track.id])
//        musicPlayer.append(newQueueDescriptor)
        musicPlayer.perform(queueTransaction: { (mutableQueue) in
            let newQueueDescriptor: MPMusicPlayerStoreQueueDescriptor = MPMusicPlayerStoreQueueDescriptor.init(storeIDs: [String(describing: track.trackId)])
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
                if Int(item.playbackStoreID) == track.trackId && index != 0 {
                    mutableQueue.remove(item)
                    self.internalTrackList.remove(at: index)
                }
            }
        }) { (queue, error) in
            onRemove(self.internalTrackList)
        }
    }
}
