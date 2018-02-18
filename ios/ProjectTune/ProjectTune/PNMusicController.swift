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
    private var musicPlaybackDelegate: PNMusicPlaybackDelegate

    
    init(withTracks: [PNTrack], delegate: PNMusicPlaybackDelegate) {
        internalTrackList = withTracks
        var internalTrackIdList: [String] = []
        for track in internalTrackList {
            internalTrackIdList.append("\(track.trackId ?? 0)")
        }
        let queueDescriptor = MPMusicPlayerStoreQueueDescriptor.init(storeIDs: internalTrackIdList)
        musicPlayer = MPMusicPlayerController.applicationQueuePlayer
        musicPlayer.setQueue(with: queueDescriptor)
        musicPlayer.prepareToPlay()
        musicPlaybackDelegate = delegate
        //observe()
    }
    
    fileprivate func observe(){
        NotificationCenter.default.addObserver(self, selector: #selector(onPlayingItemChanged), name: NSNotification.Name.MPMusicPlayerControllerNowPlayingItemDidChange, object: nil)
        musicPlayer.beginGeneratingPlaybackNotifications()
    }
    
    @objc func onPlayingItemChanged(){
        musicPlaybackDelegate.onPlayingItemChanged(playingItem: musicPlayer.nowPlayingItem)
    }
    
    func addSong(newSong: PNTrack) {
        print("dedw")
        let newQueueDescriptor = MPMusicPlayerStoreQueueDescriptor.init(storeIDs: ["\(newSong.trackId!)"])
        musicPlayer.append(newQueueDescriptor)
    }
    
    func updateQueue(newQueue: [PNTrack]){
        
        
//        musicPlayer.setQueue(with: queueDescriptor)
//        musicPlayer.prepareToPlay()
        /*var queueNew = newQueue
        musicPlayer.perform(queueTransaction: { (mutableQueue) in
            let queueItems = mutableQueue.items
            var indexesToRemove: [Int] = []
            for itemInNewQueue in newQueue {
                var index = 0
                for itemInQueue in queueItems {
                    if String(describing: itemInNewQueue.trackId) == itemInQueue.playbackStoreID {
                        indexesToRemove.append(index)
                    }
                    index = index + 1
                }
            }
            for toRemove in indexesToRemove {
                queueNew.remove(at: toRemove)
            }
            let queueDescriptor = MPMusicPlayerStoreQueueDescriptor.init(storeIDs: self.updateInternalTrackList(tracks: queueNew))
            self.musicPlayer.append(queueDescriptor)
        }) { (queue, error) in
            print(error)
        }*/
    }
    
    func updateInternalTrackList(tracks: [PNTrack]) -> [String]{
        internalTrackList = tracks
        var internalTrackIdList: [String] = []
        for track in internalTrackList {
            internalTrackIdList.append("\(track.trackId ?? 0)")
        }
        return internalTrackIdList
        
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
                if (self.musicPlayer.playbackState != .playing)
                {
                    self.musicPlayer.play()
                }
                let itemToPlay = mediaItems[index]
                self.musicPlayer.nowPlayingItem = itemToPlay
                self.musicPlaybackDelegate.onPlayIndex(index)
            }, completionHandler: { (queue, error) in
                print(error)
            })
        }
        
    }
    
    func play() -> Void {
        //if musicPlayer.playbackState == .playing || musicPlayer.playbackState == .stopped {
            musicPlayer.play()

        //}
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

        let newQueueDescriptor: MPMusicPlayerStoreQueueDescriptor = MPMusicPlayerStoreQueueDescriptor.init(storeIDs: [String(describing: track.trackId)])

        if (internalTrackList.count == 0){
            self.musicPlayer.append(newQueueDescriptor)
            self.internalTrackList.append(track)
        } else {
            musicPlayer.perform(queueTransaction: { (mutableQueue) in
                let queueItems = mutableQueue.items
                mutableQueue.insert(newQueueDescriptor, after: queueItems[queueItems.count-1])
                self.internalTrackList.append(track)
            }) { (queue, error) in
                onAdd(self.internalTrackList)
            }
        }
    }
    
    func remove(track: PNTrack, onRemoveFinished onRemove: @escaping ([PNTrack]) -> Void) {
        musicPlayer.perform(queueTransaction: { (mutableQueue) in
            let queueItems = mutableQueue.items
            for index in 0..<queueItems.count {
                let item = queueItems[index]
                if Int(item.playbackStoreID) == track.trackId {
                    mutableQueue.remove(item)
                    self.internalTrackList.remove(at: index)
                }
            }
        }) { (queue, error) in
            onRemove(self.internalTrackList)
        }
    }
}
