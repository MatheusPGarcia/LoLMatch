//
//  FeedService.swift
//  LoLMatch
//
//  Created by Matheus Garcia on 09/11/18.
//  Copyright © 2018 Matheus Garcia. All rights reserved.
//

import Foundation

class FeedService {

    /// Method responsible to retrieve all Users to show in feed
    ///
    /// - Parameter completion: users array
    public static func getFeed(completion: @escaping ([User]?) -> Void) {

        UserServices.getAllUsers { (users) in

            guard let users = users else { return }
            guard let currentUser = UserServices.getCurrentUser() else { return  }

            let laneWanted1 = currentUser.duoLane1
            let laneWanted2 = currentUser.duoLane2

            var filteredUsers = [User]()

            for user in users where user.accountId != currentUser.accountId {
                if laneWanted1 == user.lane1 || laneWanted1 == user.lane2 {
                    filteredUsers.append(user)
                } else if laneWanted2 == user.lane1 || laneWanted2 == user.lane2 {
                    filteredUsers.append(user)
                }
            }

            completion(filteredUsers)
        }
    }
}
