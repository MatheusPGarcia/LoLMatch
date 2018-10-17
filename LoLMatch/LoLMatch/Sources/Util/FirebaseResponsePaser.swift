//
//  FirebaseResponsePaser.swift
//  LoLMatch
//
//  Created by Scarpz on 17/10/18.
//  Copyright © 2018 Matheus Garcia. All rights reserved.
//

import Foundation

class FirebaseResponsePaser {
    
    static func parseUsers(from dict: [String : Any]) -> [User]? {
        
        var users = [User]()
        
        for key in dict.keys {
            
            let userDict = dict[key] as! [String : Any]
            
            let name = userDict["summonerName"] as! String
            let summonerId = userDict["summonerId"] as! Int
            let accountId = userDict["accountId"] as! Int
            let lane1 = Lane(value: userDict["lane1"] as! String)
            let lane2 = Lane(value: userDict["lane2"] as! String)
            let duolane1 = Lane(value: userDict["duoLane1"] as! String)
            let duolane2 = Lane(value: userDict["duoLane2"] as! String)
            
            users.append(User(summonerName: name, summonerId: summonerId, accountId: accountId, lane1: lane1, lane2: lane2, duoLane1: duolane1, duoLane2: duolane2))
        }
        
        return users
    }

}
