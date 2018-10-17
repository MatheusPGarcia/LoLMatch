//
//  FirebaseManager.swift
//  LoLMatch
//
//  Created by Scarpz on 17/10/18.
//  Copyright © 2018 Matheus Garcia. All rights reserved.
//

import Foundation
import FirebaseDatabase

class FirebaseManager {
    
    private static var ref: DatabaseReference! = Database.database().reference()
    
    static func getAllUsers(completion: @escaping (([String : Any]?) -> Void)) {
        
        self.ref.child("Users").observeSingleEvent(of: .value) { snapshot in
            completion(snapshot.value as? [String : Any])
        }
    }
}
