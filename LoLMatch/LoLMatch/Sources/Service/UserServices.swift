//
//  UserServices.swift
//  LoLMatch
//
//  Created by Scarpz on 17/10/18.
//  Copyright © 2018 Matheus Garcia. All rights reserved.
//

import Foundation

class UserServices {
    
    /// Method responsible to get the current User of the application
    /// TODO: NOW MOCKED
    ///
    /// - Returns: Returns the current User logged in the app
    static func getCurrentUser() -> User {
        
        return User(summonerName: "scarpz", summonerId: 2017255, accountId: 200228270, lane1: .mid, lane2: .sup, duoLane1: .jungle, duoLane2: .adc)
    }
    
    /// Method responsible to retrieve all Users from Database
    ///
    /// - Parameter completion: Array of all Users
    static func getAllUsers(completion: @escaping (([User]?) -> Void)) {
        
        FirebaseManager.getAllUsers { users in
            if let validUsers = users {
                completion(FirebaseResponsePaser.parseUsers(from: validUsers))
            } else {
                completion(nil)
            }
        }
    }
    
    /// Method responsible to retrieve all summonerIds from the current User (summonerId)
    ///
    /// - Parameters:
    ///   - completion: Array of Ids from people who like the current User
    static func getAllReceivedLikes(completion: @escaping ([Int]?) -> Void) {
        
        let currentSummonerId = UserServices.getCurrentUser().summonerId
        
        FirebaseManager.getAllReceivedLikes(from: currentSummonerId) { receivedLikes in
            if let validLikes = receivedLikes {
                
                var summonerIdList = [Int]()
                
                for key in validLikes.keys {
                    if let summonerId = Int(key) {
                        summonerIdList.append(summonerId)
                    }
                }
                completion(summonerIdList)
            } else {
                completion(nil)
            }
        }
    }
    
    /// Method responsible to retrieve all summonerIds from the current User (summonerId)
    ///
    /// - Parameters:
    ///   - completion: Array of Ids from people who like the current User
    static func getAllMatches(completion: @escaping ([Int]?) -> Void) {
        
        let currentSummonerId = UserServices.getCurrentUser().summonerId
        
        FirebaseManager.getAllMatches(from: currentSummonerId) { matches in
            if let validMatches = matches {
                
                var summonerIdList = [Int]()
                
                for key in validMatches.keys {
                    if let summonerId = Int(key) {
                        summonerIdList.append(summonerId)
                    }
                }
                completion(summonerIdList)
            } else {
                completion(nil)
            }
        }
    }
    
    /// Method responsible to perform a Like from the current User to another one
    ///
    /// - Parameters:
    ///   - summonerId: Id of the user who will be liked
    ///   - completion: Success boolean value
    static func likeUser(summonerId: Int, completion: @escaping ((Bool) -> Void)) {
        
        let currentSummonerId = UserServices.getCurrentUser().summonerId
        
        FirebaseManager.getAllReceivedLikes(from: summonerId) { receivedLikes in
            
            if let validLikes = receivedLikes {
                
                // If the current User already was liked by the user in the moment, perform a Match
                if let _ = validLikes.first(where: { $0.key == "\(currentSummonerId)" }) {
                    FirebaseManager.matchUser(currentSummonerId: currentSummonerId, summonerId: summonerId, completion: { success in
                        completion(success)
                    })
                    
                // Otherwise, just like it
                } else {
                    FirebaseManager.likeUser(currentSummonerId: currentSummonerId, summonerId: summonerId) { success in
                        completion(success)
                    }
                }
                
            } else {
                completion(false)
            }
        }
    }
    
    /// Method responsible to perform a Match from a User to another one
    ///
    /// - Parameters:
    ///   - summonerId: Id of the user who will be matched
    ///   - completion: Success boolean value
    static func matchUser(summonerId: Int, completion: @escaping ((Bool) -> Void)) {
        
         let currentSummonerId = UserServices.getCurrentUser().summonerId
        
        FirebaseManager.matchUser(currentSummonerId: currentSummonerId, summonerId: summonerId) { success in
            completion(success)
        }
        
    }
        
}
