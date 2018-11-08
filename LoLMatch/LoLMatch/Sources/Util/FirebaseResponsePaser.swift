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
        
        var users = [User]()
        
        for key in dict.keys {
            let userJson = try JSONSerialization.data(withJSONObject: dict[key]!, options: .prettyPrinted)
            users.append(try JSONDecoder().decode(User.self, from: userJson))
        }
        
        return users
    }
}
