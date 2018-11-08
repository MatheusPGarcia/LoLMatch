//
//  PlayerInMatch.swift
//  LoLMatch
//
//  Created by Matheus Garcia on 08/11/18.
//  Copyright © 2018 Matheus Garcia. All rights reserved.
//

import Foundation

struct PlayerInMatch: Codable {

    var summonerId: Int?
    var participantId: Int?
}

extension PlayerInMatch {

    enum mainKeys: String, CodingKey {
        case player
        case participantId
    }

    enum nestedKey: String, CodingKey {
        case summonerId
    }

    init(from decoder: Decoder) throws {

        let container = try decoder.container(keyedBy: mainKeys.self)
        let nested = try container.nestedContainer(keyedBy: nestedKey.self, forKey: .player)

        let participantId = try container.decodeIfPresent(Int.self, forKey: .participantId)
        let summonerId = try nested.decodeIfPresent(Int.self, forKey: .summonerId)

        self.participantId = participantId
        self.summonerId = summonerId
    }
}
