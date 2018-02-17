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

extension JSONEncoder {
    func encodeJSONObject<T: Encodable>(_ value: T, options opt: JSONSerialization.ReadingOptions = []) throws -> Any {
        let data = try encode(value)
        return try JSONSerialization.jsonObject(with: data, options: opt)
    }
}

extension JSONDecoder {
    func decode<T: Decodable>(_ type: T.Type, withJSONObject object: Any, options opt: JSONSerialization.WritingOptions = []) throws -> T {
        let data = try JSONSerialization.data(withJSONObject: object, options: opt)
        return try decode(T.self, from: data)
    }
}
