//
//  UserServices.swift
//  LoLMatch
//
//  Created by Scarpz on 17/10/18.
//  Copyright © 2018 Matheus Garcia. All rights reserved.
//

import Foundation

class UserServices {
    
    static func getAllUsers(completion: @escaping (([User]?) -> Void)) {
        
        FirebaseManager.getAllUsers { users in
            if users != nil {
                completion(FirebaseResponsePaser.parseUsers(from: users!))
            } else {
                completion(nil)
            }
        }
    }
    
}
