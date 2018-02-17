//
//  PNNetwork.swift
//  ProjectTune
//
//  Created by Arnold Balliu on 2/17/18.
//  Copyright © 2018 GroupTune. All rights reserved.
//

import Foundation
import Alamofire
import PromiseKit

class PNNetwork {
    
    private static let ITUNES_API_BASE_URL = "https://itunes.apple.com/search?country=US"
    
    static func fetchTracksWith(term: String) -> Promise<PNNetworkItunesSearchResponse> {
        var resultURL = ""
        resultURL = appendToURL(ITUNES_API_BASE_URL, key: "entity", value: "song")
        resultURL = appendToURL(resultURL, key: "media", value: "music")
        resultURL = appendToURL(resultURL, key: "term", value: term)
        
        return Alamofire.request(resultURL, method: .get).responseCodable()
        
    }
    
    private static func appendToURL(_ url: String, key:String, value:String) -> String {
        
        var escapedString = value.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        return url + "&" + key + "=" + escapedString!
    }
    
    struct PNNetworkError: LocalizedError {
        
        var title: String?
        var code: Int
        var errorDescription: String? { return _description }
        var failureReason: String? { return _description }
        
        private var _description: String
        
        init(title: String?, description: String, code: Int) {
            self.title = title ?? "Error"
            self._description = description
            self.code = code
        }
    }
    
}
