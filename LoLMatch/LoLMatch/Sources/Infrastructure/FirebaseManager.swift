//
//  FirebaseManager.swift
//  LoLMatch
//
//  Created by Scarpz on 17/10/18.
//  Copyright © 2018 Matheus Garcia. All rights reserved.
//

import Foundation
import FirebaseDatabase

enum ChildNames: String {
    case users = "Users"
    case receivedLikes = "receivedLikes"
    case matches = "matches"
}

class FirebaseManager {
    
    /// Referente of the Firebase Database
    private static var ref: DatabaseReference! = Database.database().reference()
    
    /// Method responsible to access Firebase Database to get all the Users
    ///
    /// - Parameter completion: Dictionary with all the Users in batabase
    static func getAllUsers(completion: @escaping (([String : Any]?) -> Void)) {
        
        self.ref.child(ChildNames.users.rawValue).observeSingleEvent(of: .value) { snapshot in
            
            if let response = snapshot.value as? [String : Any] {
                completion(response)
            } else {
                completion(nil)
            }
        }
    }
    
    /// Method responsible to get all the receivedLikes from a specific summonerId from Firebase
    ///
    /// - Parameters:
    ///   - summonerId: Id of a summoner to get the likes of
    ///   - completion: Dictionary of summonerIds
    static func getAllReceivedLikes(from summonerId: Int, completion: @escaping (([String : Any]?) -> Void)) {
        
        self.ref.child(ChildNames.users.rawValue).child("\(summonerId)").child(ChildNames.receivedLikes.rawValue).observeSingleEvent(of: .value) { snapshot in
            
            if let response = snapshot.value as? [String : Any] {
                completion(response)
            } else {
                completion(nil)
            }
        }
    }
    
    /// Method responsible to get all the matches from a specific summonerId from Firebase
    ///
    /// - Parameters:
    ///   - summonerId: Id of the summoner to get the matches of
    ///   - completion: Array of summonerIds
    static func getAllMatches(from summonerId: Int, completion: @escaping (([String : Any]?) -> Void)) {
        
        self.ref.child(ChildNames.users.rawValue).child("\(summonerId)").child(ChildNames.matches.rawValue).observeSingleEvent(of: .value) { snapshot in
            
            if let response = snapshot.value as? [String : Any] {
                completion(response)
            } else {
                completion(nil)
            }
        }
    }
    
    /// Method responsible to perform a Like from a User to another one
    ///
    /// - Parameters:
    ///   - currentSummonerId: Id of the current user
    ///   - summonerId: Id of the user who will be liked
    ///   - completion: Success boolean value
    static func likeUser(currentSummonerId: Int, summonerId: Int, completion: @escaping ((Bool) -> Void)) {
        
        let date = Date().parseToString(format: "MM/dd/yyyy HH:mm")
        
        self.ref.child(ChildNames.users.rawValue).child("\(summonerId)").child(ChildNames.receivedLikes.rawValue).child("\(currentSummonerId)").setValue(["date" : date])
        
        completion(true)
    }
    
    /// Method responsible to perform a Match from a User to another one
    ///
    /// - Parameters:
    ///   - currentSummonerId: Id of the current user
    ///   - summonerId: Id of the user who will be matched
    ///   - completion: Success boolean value
    static func matchUser(currentSummonerId: Int, summonerId: Int, completion: @escaping ((Bool) -> Void)) {
        
        self.ref.child(ChildNames.users.rawValue).child("\(currentSummonerId)").child(ChildNames.receivedLikes.rawValue).child("\(summonerId)").removeValue()
        
        let date = Date().parseToString(format: "MM/dd/yyyy HH:mm")
        
        self.ref.child(ChildNames.users.rawValue).child("\(currentSummonerId)").child(ChildNames.matches.rawValue).child("\(summonerId)").setValue(["date" : date])
        
        self.ref.child(ChildNames.users.rawValue).child("\(summonerId)").child(ChildNames.matches.rawValue).child("\(currentSummonerId)").setValue(["date" : date])
        
        completion(true)
    }
    
    /// Method responsible to set all the lanes for a given user
    ///
    /// - Parameter user: User to be updated
    static func setLanes(user: User) {
        self.ref.child("Users").child("\(user.summonerId)").updateChildValues(user.toDict()) { (error, reference) in
            // TODO
            print(error?.localizedDescription ?? "OKOK")
        }
    }
}
