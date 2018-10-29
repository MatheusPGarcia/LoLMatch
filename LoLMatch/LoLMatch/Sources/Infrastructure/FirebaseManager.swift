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
    
    /// Referente of the Firebase Database
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
    
    /// Method responsble to get all the receivedLikes from a specific summonerId
    ///
    /// - Parameters:
    ///   - summonerId: Id of the summoner to get the likes
    ///   - completion: Array of summonerIds
    static func getAllReceivedLikes(from summonerId: String, completion: @escaping (([Int]?) -> Void)) {
        
        self.ref.child("Users").child(summonerId).child("receivedLikes").observeSingleEvent(of: .value) { snapshot in
            // Used as Int Optional because if a value in the middle of array is deleted,
            // Firebase returns an array with null in the previous deleted indexes
            if let response = snapshot.value as? [Int?] {
                // Remove the nil values
                completion(response.compactMap({ $0 }))
            } else {
                completion(nil)
            }
        }
    }
    
    /// Method responsble to get all the matches from a specific summonerId
    ///
    /// - Parameters:
    ///   - summonerId: Id of the summoner to get the matches
    ///   - completion: Array of summonerIds
    static func getAllMatches(from summonerId: String, completion: @escaping (([Int]?) -> Void)) {
        
        self.ref.child("Users").child(summonerId).child("matches").observeSingleEvent(of: .value) { snapshot in
            // Used as Int Optional because if a value in the middle of array is deleted,
            // Firebase returns an array with null in the previous deleted indexes
            if let response = snapshot.value as? [Int?] {
                // Remove the nil values
                completion(response.compactMap({ $0 }))
            } else {
                completion(nil)
            }
        }
    }
    
    /// Method responsible to perform a Like from a User to another one
    ///
    /// - Parameters:
    ///   - currentSummonerId: Id of the user who will like other user
    ///   - summonerId: Id of the user who will be liked
    ///   - completion: Success boolean value
    static func likeUser(currentSummonerId: Int, summonerId: String, completion: @escaping ((Bool) -> Void)) {
        
        self.ref.child("Users").child(summonerId).child("receivedLikes").observeSingleEvent(of: .value) { snapshot in
            // Used as Int Optional because if a value in the middle of array is deleted,
            // Firebase returns an array with null in the previous deleted indexes
            if let response = snapshot.value as? [Int?] {
                
                // Remove the nil values
                var usersId = response.compactMap({ $0 })
                usersId.append(currentSummonerId)
                self.ref.child("Users").child(summonerId).child("receivedLikes").setValue(usersId)
                
            } else {
                self.ref.child("Users").child(summonerId).child("receivedLikes").setValue([currentSummonerId])
            }
            completion(true)
        }
    }
    
    /// Method responsible to perform a Match from a User to another one
    ///
    /// - Parameters:
    ///   - currentSummonerId: Id of the user who will match with other user
    ///   - summonerId: Id of the user who will be matched
    ///   - completion: Success boolean value
    static func matchUser(currentSummonerId: Int, summonerId: Int, completion: @escaping ((Bool) -> Void)) {
        
        self.ref.child("Users").child("\(currentSummonerId)").child("receivedLikes").observeSingleEvent(of: .value) { snapshot in
            // Used as Int Optional because if a value in the middle of array is deleted,
            // Firebase returns an array with null in the previous deleted indexes
            guard let response = snapshot.value as? [Int?] else {
                completion(false)
                return
            }
            // Remove the nil values
            var usersId = response.compactMap({ $0 })
            if let summonerIndex = usersId.index(where: { $0 == summonerId }) {
                
                // Remove the User from my Received Likes
                usersId.remove(at: summonerIndex)
                
                // Update the Received Likes Node of the Current User in Firebase
                self.ref.child("Users").child("\(currentSummonerId)").child("receivedLikes").setValue(usersId)
                self.setMatch(currentSummonerId: currentSummonerId, summonerId: summonerId, completion: { _ in completion(true) })
                
            } else {
                completion(false)
            }
        }
    }
    
    private static func setMatch(currentSummonerId: Int, summonerId: Int, completion: @escaping ((Bool) -> Void)) {
        
        // Set the match for the first User
        self.ref.child("Users").child("\(currentSummonerId)").child("matches").observeSingleEvent(of: .value) { snapshot in
            // Used as Int Optional because if a value in the middle of array is deleted,
            // Firebase returns an array with null in the previous deleted indexes
            if let response = snapshot.value as? [Int?] {

                // Remove the nil values
                var usersId = response.compactMap({ $0 })
                usersId.append(currentSummonerId)
                self.ref.child("Users").child("\(summonerId)").child("matches").setValue(usersId)

            } else {
                self.ref.child("Users").child("\(summonerId)").child("matches").setValue([currentSummonerId])
            }
        
            // Set the match for the second User
            self.ref.child("Users").child("\(summonerId)").child("matches").observeSingleEvent(of: .value) { snapshot in
                // Used as Int Optional because if a value in the middle of array is deleted,
                // Firebase returns an array with null in the previous deleted indexes
                if let response = snapshot.value as? [Int?] {

                    // Remove the nil values
                    var usersId = response.compactMap({ $0 })
                    usersId.append(summonerId)
                    self.ref.child("Users").child("\(currentSummonerId)").child("matches").setValue(usersId)

                } else {
                    self.ref.child("Users").child("\(currentSummonerId)").child("matches").setValue([summonerId])
                }
                completion(true)
            }
        }
    }
}
