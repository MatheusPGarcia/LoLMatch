//
//  Stats.swift
//  LoLMatch
//
//  Created by Matheus Garcia on 08/11/18.
//  Copyright © 2018 Matheus Garcia. All rights reserved.
//

import Foundation

struct Stats: Codable {

    var participantId: Int?
    var championId: Int?
    var kills: Int?
    var deaths: Int?
    var assists: Int?
}

extension Stats {

    enum mainKeys: String, CodingKey {
        case participantId
        case championId
        case stats
    }

    enum nestedKeys: String, CodingKey {
        case kills
        case deaths
        case assists
    }

    init(from decoder: Decoder) throws {

        let container = try decoder.container(keyedBy: mainKeys.self)
        let nested = try container.nestedContainer(keyedBy: nestedKeys.self, forKey: .stats)

        let participantId = try container.decodeIfPresent(Int.self, forKey: .participantId)
        let championId = try container.decodeIfPresent(Int.self, forKey: .championId)
        let kills = try nested.decodeIfPresent(Int.self, forKey: .kills)
        let deaths = try nested.decodeIfPresent(Int.self, forKey: .deaths)
        let assists = try nested.decodeIfPresent(Int.self, forKey: .assists)

        self.participantId = participantId
        self.championId = championId
        self.kills = kills
        self.deaths = deaths
        self.assists = assists
    }
}
