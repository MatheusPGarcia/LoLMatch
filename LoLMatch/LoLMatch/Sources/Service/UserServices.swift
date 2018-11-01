//
//  UserServices.swift
//  LoLMatch
//
//  Created by Scarpz on 17/10/18.
//  Copyright © 2018 Matheus Garcia. All rights reserved.
//

import Foundation

class UserServices: BaseService {
    
    /// Method responsible to get the current User of the application
    ///
    /// - Returns: Returns the current User logged in the app
    static func getCurrentUser() -> User? {
        return UserDefaultsManager.getCurrentUser()
    }
    
    /// Method responsible to set the current User of the application
    ///
    /// - Parameter user: User to be saved
    static func setCurrentUser(user: User?) {
        UserDefaultsManager.setCurrentUser(user: user)
    }
    
    /// Method responsible to set the lanes of User of the application
    ///
    /// - Parameter user: User to be have the laes set
    static func setLanes(user: User) {
        FirebaseManager.setLanes(user: user)
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
        
        if let currentUser = self.getCurrentUser() {
            
            let currentSummonerId = currentUser.summonerId
            
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
        } else {
            completion(nil)
        }
    }
    
    /// Method responsible to retrieve all summonerIds from the current User (summonerId)
    ///
    /// - Parameters:
    ///   - completion: Array of Ids from people who like the current User
    static func getAllMatches(completion: @escaping ([Int]?) -> Void) {
        
        if let currentUser = self.getCurrentUser() {
            
             let currentSummonerId = currentUser.summonerId
            
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
        } else {
            completion(nil)
        }
    }
    
    /// Method responsible to perform a Like from the current User to another one
    ///
    /// - Parameters:
    ///   - summonerId: Id of the user who will be liked
    ///   - completion: Success boolean value
    static func likeUser(summonerId: Int, completion: @escaping ((Bool) -> Void)) {
        
        if let currentUser = self.getCurrentUser() {
            
            let currentSummonerId = currentUser.summonerId
            
            FirebaseManager.getAllReceivedLikes(from: currentSummonerId) { receivedLikes in
                
                if let validLikes = receivedLikes {
                    
                    // If the current User already was liked by the user in the moment, perform a Match
                    if let _ = validLikes.first(where: { $0.key == "\(summonerId)" }) {
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
                    FirebaseManager.likeUser(currentSummonerId: currentSummonerId, summonerId: summonerId) { success in
                        completion(success)
                    }
                }
            }
        } else {
            completion(false)
        }
    }
    
    /// Method responsible to perform a Match from a User to another one
    ///
    /// - Parameters:
    ///   - summonerId: Id of the user who will be matched
    ///   - completion: Success boolean value
    static func matchUser(summonerId: Int, completion: @escaping ((Bool) -> Void)) {
        
        if let currentUser = self.getCurrentUser() {
            
            let currentSummonerId = currentUser.summonerId
            
            FirebaseManager.matchUser(currentSummonerId: currentSummonerId, summonerId: summonerId) { success in
                completion(success)
            }
        } else {
            completion(false)
        }
    }
    
    /// Method responsible to get the summoner information
    ///
    /// - Parameters:
    ///   - summonerName: Summoner name to be search
    ///   - completion: Return the UserIdProfile from the API
    static func getSummonerId(byName summonerName: String, completion: @escaping (UserIdProfile?, Error?) -> Void) {
        
        let target = RiotProvider.getUserId(summonerName: summonerName)
        
        request(provider: riotProvider, target: target, type: UserIdProfile.self, completion: completion)
    }
    
    /// Method responsible to get the elo status from a specific Summoner
    ///
    /// - Parameters:
    ///   - summonerId: Summoner Id
    ///   - completion: Returns the array of Elos (of each queue) of this Summoner
    static func getElo(byId summonerId: Int, completion: @escaping ([Elo]?, Error?) -> Void) {
        
        let target = RiotProvider.getElo(summonerId: summonerId)
        
        request(provider: riotProvider, target: target, type: [Elo].self, completion: completion)
    }
}
