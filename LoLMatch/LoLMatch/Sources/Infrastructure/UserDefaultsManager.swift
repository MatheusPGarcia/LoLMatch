//
//  UserDefaultsManager.swift
//  LoLMatch
//
//  Created by Scarpz on 01/11/18.
//  Copyright © 2018 Matheus Garcia. All rights reserved.
//

import Foundation

class UserDefaultsManager {
    
    static private let userDefaults = UserDefaults.standard
    
    static func getCurrentUser() -> User? {
//        if let userDict = self.userDefaults.object(forKey: "currentUser") as? [String : Any] {
        if let userData = self.userDefaults.data(forKey: "currentUser") {
            
            do {
                return try JSONDecoder().decode(User.self, from: userData)
            } catch let error {
                logger.debug(error)
                return nil
            }
        } else {
            return nil
        }
    }
    
    static func setCurrentUser(user: User?) {
        do {
            self.userDefaults.set(try JSONEncoder().encode(user), forKey: "currentUser")
            self.userDefaults.synchronize()
        } catch {
            
        }
    }
}
