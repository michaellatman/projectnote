//
//  PNMusicControllerProtocol.swift
//  ProjectTune
//
//  Created by Arnold Balliu on 2/17/18.
//  Copyright © 2018 GroupTune. All rights reserved.
//

import Foundation

protocol PNMusicControllerProtocol {
    func skipPrevious()
    func skipNext()
    func play()
    func pause()
    func stop()
    func playIndex(index: Int)
}
