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
        if let userDict = self.userDefaults.object(forKey: "currentUser") as? [String : Any] {
            return User(dict: userDict)
        } else {
            return nil
        }
    }
    
    static func setCurrentUser(user: User) {
        self.userDefaults.set(user.toDict(), forKey: "currentUser")
        self.userDefaults.synchronize()
    }
}
