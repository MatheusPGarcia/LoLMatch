//
//  Elo.swift
//  LoLMatch
//
//  Created by Matheus Garcia on 01/11/18.
//  Copyright © 2018 Matheus Garcia. All rights reserved.
//

import Foundation

struct Elo: Codable {

    var queueType: String?
    var rank: String?
    var tier: String?
    var wins: Int?
    var losses: Int?
}

extension Elo {

    enum responseKeys: String, CodingKey {
        case queueType
        case rank
        case tier
        case wins
        case losses
    }

    init(from decoder: Decoder) throws {

        let container = try decoder.container(keyedBy: responseKeys.self)

        let queueType = try container.decodeIfPresent(String.self, forKey: .queueType)
        let rank = try container.decodeIfPresent(String.self, forKey: .rank)
        let tier = try container.decodeIfPresent(String.self, forKey: .tier)
        let wins = try container.decodeIfPresent(Int.self, forKey: .wins)
        let losses = try container.decodeIfPresent(Int.self, forKey: .losses)

        self.queueType = queueType
        self.rank = rank
        self.tier = tier
        self.wins = wins
        self.losses = losses
    }
}
