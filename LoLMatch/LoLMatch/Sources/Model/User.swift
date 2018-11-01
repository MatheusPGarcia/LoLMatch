//
//  User.swift
//  LoLMatch
//
//  Created by Scarpz on 17/10/18.
//  Copyright © 2018 Matheus Garcia. All rights reserved.
//

import Foundation

struct User {
    var summonerName: String
    var summonerId: Int
    var accountId: Int
    var lane1: Lane
    var lane2: Lane
    var duoLane1: Lane
    var duoLane2: Lane
    
    init(summonerName: String, summonerId: Int, accountId: Int, lane1: Lane, lane2: Lane, duoLane1: Lane, duoLane2: Lane) {
        
        self.summonerName = summonerName
        self.summonerId = summonerId
        self.accountId = accountId
        self.lane1 = lane1
        self.lane2 = lane2
        self.duoLane1 = duoLane1
        self.duoLane2 = duoLane2
    }
    
    init(dict: [String : Any]) {
        self.summonerName = dict["summonerName"] as! String
        self.summonerId = dict["summonerId"] as! Int
        self.accountId = dict["accountId"] as! Int
        self.lane1 = Lane(value: dict["lane1"] as! String)
        self.lane2 = Lane(value: dict["lane2"] as! String)
        self.duoLane1 = Lane(value: dict["duoLane1"] as! String)
        self.duoLane2 = Lane(value: dict["duoLane2"] as! String)
    }
    
    func toDict() -> [String : Any] {
        
        var userDict: [String : Any] = [:]
        
        userDict["summonerName"] = self.summonerName
        userDict["summonerId"] = self.summonerId
        userDict["accountId"] = self.accountId
        userDict["lane1"] = self.lane1.keyDescription()
        userDict["lane2"] = self.lane2.keyDescription()
        userDict["duoLane1"] = self.duoLane1.keyDescription()
        userDict["duoLane2"] = self.duoLane2.keyDescription()
        
        return userDict
    }
}
