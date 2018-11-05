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
    static func parseUsers(from dict: [String : Any]) throws -> [User] {
        
        let usersJson = try JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
        let users = try JSONDecoder().decode([User].self, from: usersJson)
        
        return users
    }
}
