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
    
    // MARK: - User Information
    static func getCurrentUser() -> User? {
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
            print("Error on setting Current User")
        }
    }
    
    
    // MARK: - Champions Information
    static func getChampionList() -> [Champion]? {
        if let championsData = self.userDefaults.data(forKey: "championList") {
            
            do {
                return try JSONDecoder().decode([Champion].self, from: championsData)
            } catch let error {
                logger.debug(error)
                return nil
            }
        } else {
            return nil
        }
    }
    
    static func setChampionList(champions: [Champion]?) {
        do {
            self.userDefaults.set(try JSONEncoder().encode(champions), forKey: "championList")
            self.userDefaults.synchronize()
        } catch {
            print("Error on setting champion List")
        }
    }
}
