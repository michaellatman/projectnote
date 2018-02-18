//
//  PNFirebase.swift
//  ProjectTune
//
//  Created by Arnold Balliu on 2/17/18.
//  Copyright © 2018 GroupTune. All rights reserved.
//

import Foundation
import FirebaseFirestore
import PromiseKit

class PNFirebase {
    
    /**
    * To be used by host device
    */
    static func startBroadcast(broadcastId: String, broadcastName: String, deviceName: String){
        let db = Firestore.firestore()
        let broadcastDocument = db.collection("broadcast").document(broadcastId)
        let broadcastLocal = PNBroadcast.init(broadcastId, broadcastName, deviceName)
        
        let jsonEncoder = JSONEncoder()
        do {
            let jsonData = try jsonEncoder.encodeJSONObject(broadcastLocal)
            broadcastDocument.setData(jsonData as! [String : Any], completion: { (error) in
                if let error = error {
                    print("Error writing document: \(error)")
                } else {
                    print("Document successfully written!")
                }
            })
        }
        catch {
            print("Encoding failed")
        }
    }
    
    /**
     * To be used by host device
     */
    static func endBroadcast(broadcastId: String) {
        let db = Firestore.firestore()
        let broadcastDocument = db.collection("broadcast").document(broadcastId)
        broadcastDocument.delete()
    }
    
    static func getQueue(broadcastId: String, completion: @escaping ([PNTrack]?, Error?) -> Void) {
        let db = Firestore.firestore()
        let queueCollection = db.collection("broadcast").document(broadcastId).collection("queue")
        queueCollection.addSnapshotListener { (snapshot, error) in
            if let error = error {
                print("Error setting queue listener: \(error)")
                completion(nil, error)
            } else {
                var trackList: [PNTrack] = []
                for document in snapshot!.documents.reversed() {
                    let track = PNTrack.init(dictionary: document.data())
                    trackList.append(track)
                }
                completion(trackList, nil)
            }
        }
    }
    
    static func updateQueue(){
        
    }
    
    static func add(track: PNTrack, broadcastId: String){
        let db = Firestore.firestore()
        let queueCollection = db.collection("broadcast").document(broadcastId).collection("queue")
        let trackDocument = queueCollection.document()
        
        let jsonEncoder = JSONEncoder()
        do {
            let jsonData = try jsonEncoder.encodeJSONObject(track)
            trackDocument.setData(jsonData as! [String : Any], completion: { (error) in
                if let error = error {
                    print("Error writing document: \(error)")
                } else {
                    print("Document successfully written!")
                }
            })
        }
        catch {
            print("Encoding failed")
        }
    }
    
    static func remove(trackId: String, broadcastId: String){
        let db = Firestore.firestore()
        let queueCollection = db.collection("broadcast").document(broadcastId).collection("queue")
        queueCollection.whereField("trackId", isEqualTo: trackId).getDocuments { (snapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                for document in snapshot!.documents {
                    queueCollection.document(document.documentID).delete()
                }
            }
        }
    }
    
    
    
    //    enum FirebaseCollection: String {
    //        case broadcast = "broadcast"
    //        case queue = "queue"
    //    }
    //
    //    func mutate(collection: FirebaseCollection, withId: String, data: Any){
    //
    //        switch(collection){
    //            case .broadcast:  print("broadcast")
    //            case .queue: mutateQueue(broadcastId: : withId, withQueue: data as! PNQueue)
    //        }
    //    }
    //
    //    private func mutateBroadcast(withData: Any){
    //
    //    }
    //
    //    private func mutateQueue(broadcastId: String, queueId: String, withQueue: PNQueue){
    //        let db = Firestore.firestore()
    //
    //        let jsonEncoder = JSONEncoder()
    //        do {
    //            let jsonData = try jsonEncoder.encodeJSONObject(withQueue)
    //            let queueCollection = db.collection(FirebaseCollection.broadcast.rawValue).document(broadcastId).collection(FirebaseCollection.queue.rawValue)
    //            queueCollection.document(queueId).
    //
    //        }
    //        catch {
    //            print("Encoding failed")
    //        }
    //
    //
    //    }
    //
    //    func withData(_ data: Any){
    //
    //    }
    
    
}
