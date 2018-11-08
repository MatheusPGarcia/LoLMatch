//
//  User.swift
//  LoLMatch
//
//  Created by Scarpz on 17/10/18.
//  Copyright © 2018 Matheus Garcia. All rights reserved.
//

import Foundation

struct User: Codable {
    var profileIconId: Int
    var summonerName: String
    var summonerId: Int
    var accountId: Int
    var lane1: Lane
    var lane2: Lane
    var duoLane1: Lane
    var duoLane2: Lane
    
    init(profileIconId: Int, summonerName: String, summonerId: Int, accountId: Int, lane1: Lane, lane2: Lane, duoLane1: Lane, duoLane2: Lane) {
        
        self.profileIconId = profileIconId
        self.summonerName = summonerName
        self.summonerId = summonerId
        self.accountId = accountId
        self.lane1 = lane1
        self.lane2 = lane2
        self.duoLane1 = duoLane1
        self.duoLane2 = duoLane2
    }
}

// MARK: - Methods used in Firebase
extension User {
    
    func toDict() -> [String : Any] {
        
        var userDict: [String : Any] = [:]
        
        userDict["profileIconId"] = self.profileIconId
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

// MARK: - Methods used in external APIs and application
extension User {
    
    enum ResponseKeys: String, CodingKey {
        case profileIconId
        case summonerName
        case summonerId
        case accountId
        case lane1
        case lane2
        case duoLane1
        case duoLane2
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: ResponseKeys.self)
        
        let profileIconId = try container.decode(Int.self, forKey: .profileIconId)
        let summonerName = try container.decode(String.self, forKey: .summonerName)
        let summonerId = try container.decode(Int.self, forKey: .summonerId)
        let accountId = try container.decode(Int.self, forKey: .accountId)
        let lane1 = try container.decode(String.self, forKey: .lane1)
        let lane2 = try container.decode(String.self, forKey: .lane2)
        let duoLane1 = try container.decode(String.self, forKey: .duoLane1)
        let duoLane2 = try container.decode(String.self, forKey: .duoLane2)
        
        self.profileIconId = profileIconId
        self.summonerName = summonerName
        self.summonerId = summonerId
        self.accountId = accountId
        self.lane1 = Lane(value: lane1)
        self.lane2 = Lane(value: lane2)
        self.duoLane1 = Lane(value: duoLane1)
        self.duoLane2 = Lane(value: duoLane2)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: ResponseKeys.self)
        
        try container.encode(self.profileIconId, forKey: .profileIconId)
        try container.encode(self.summonerName, forKey: .summonerName)
        try container.encode(self.summonerId, forKey: .summonerId)
        try container.encode(self.accountId, forKey: .accountId)
        try container.encode(self.lane1.keyDescription(), forKey: .lane1)
        try container.encode(self.lane2.keyDescription(), forKey: .lane2)
        try container.encode(duoLane1.keyDescription(), forKey: .duoLane1)
        try container.encode(duoLane2.keyDescription(), forKey: .duoLane2)
    }
    
}
