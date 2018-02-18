//
//  PNRemoteAction.swift
//  ProjectTune
//
//  Created by Arnold Balliu on 2/17/18.
//  Copyright © 2018 GroupTune. All rights reserved.
//

import Foundation

class PNRemoteAction {
    
    private var broadcastId: String?
    
    enum ActionType: String{
        case skipPrev = "skipPrev"
        case skipNext = "skipNext"
        case togglePlayPause = "togglePlayPause"
        case playNow = "playNow"
    }
    
    init(broadcastId: String) {
        self.broadcastId = broadcastId
    }
    
    func send(_ remoteActionVal: ActionType){
        
    }
    
    
    
    func send(_ remoteActionVal: ActionType, _ actionData: [String: AnyObject]){
        
    }
    
}
