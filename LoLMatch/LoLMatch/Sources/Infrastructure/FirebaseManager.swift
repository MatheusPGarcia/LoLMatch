//
//  FirebaseManager.swift
//  LoLMatch
//
//  Created by Scarpz on 17/10/18.
//  Copyright © 2018 Matheus Garcia. All rights reserved.
//

import Foundation
import FirebaseDatabase

class FirebaseManager {
    
    private static var ref: DatabaseReference! = Database.database().reference()
    
    static func getAllUsers(completion: @escaping (([String : Any]?) -> Void)) {
        
        self.ref.child("Users").observeSingleEvent(of: .value) { snapshot in
            
            if let response = snapshot.value as? [String : Any] {
                completion(response)
            } else {
                completion(nil)
            }
        }
    }
    
    static func getAllReceivedLikes(from summonerId: String, completion: @escaping (([Int]?) -> Void)) {
        
        self.ref.child("Users").child(summonerId).child("receivedLikes").observeSingleEvent(of: .value) { snapshot in
            // Used as Int Optional because if a value in the middle of array is deleted,
            // Firebase returns an array with null in the previous deleted indexes
            if let response = snapshot.value as? [Int?] {
                completion(response.compactMap({ $0 }))
            } else {
                completion(nil)
            }
        }
    }
    
    static func likeUser(currentSummonerId: Int, summonerId: String, completion: @escaping ((Bool) -> Void)) {
        
        self.ref.child("Users").child(summonerId).child("receivedLikes").observeSingleEvent(of: .value) { snapshot in
            if var response = snapshot.value as? [Int] {
                
                response.append(currentSummonerId)
                self.ref.child("Users").child(summonerId).child("receivedLikes").setValue(response)
                
            } else {
                self.ref.child("Users").child(summonerId).child("receivedLikes").setValue([currentSummonerId])
            }
            completion(true)
        }
    }
}
