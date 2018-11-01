//
//  FirebaseResponsePaser.swift
//  LoLMatch
//
//  Created by Scarpz on 17/10/18.
//  Copyright © 2018 Matheus Garcia. All rights reserved.
//

import Foundation

class FirebaseResponsePaser {
    
    /// Functions responsible to parse all Users from Firebase
    ///
    /// - Parameter dict: JSON received from Firebase
    /// - Returns: Array of Users parsed from Firebase
    static func parseUsers(from dict: [String : Any]) -> [User] {
        
        var users = [User]()
        
        for key in dict.keys {
            
            let userDict = dict[key] as! [String : Any]

            users.append(User(dict: userDict))
        }
        
        return users
    }
}
