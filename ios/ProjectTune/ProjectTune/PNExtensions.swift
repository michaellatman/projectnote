//
//  PNExtensions.swift
//  ProjectTune
//
//  Created by Arnold Balliu on 2/17/18.
//  Copyright © 2018 GroupTune. All rights reserved.
//

import Foundation
import Alamofire
import PromiseKit

extension Alamofire.DataRequest {
    // Return a Promise for a Codable
    public func responseCodable<T: Codable>() -> Promise<T> {
        
        return Promise { completion in
            responseData(queue: nil) { response in
                switch response.result {
                case .success(let value):
                    let decoder = JSONDecoder()
                    do {
                        completion.fulfill(try decoder.decode(T.self, from: value))
                    } catch let e {
                        completion.reject(e)
                    }
                case .failure(let error):
                    completion.reject(error)
                }
            }
        }
    }
}
