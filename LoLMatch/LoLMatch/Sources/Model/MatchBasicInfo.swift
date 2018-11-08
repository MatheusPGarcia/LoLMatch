//
//  Matches.swift
//  LoLMatch
//
//  Created by Matheus Garcia on 05/11/18.
//  Copyright © 2018 Matheus Garcia. All rights reserved.
//

import Foundation

struct MatchBasicInfo: Codable {

    var gameId: Int?
    var championId: Int?
}

extension MatchBasicInfo {

    enum responseKeys: String, CodingKey {
        case gameId
        case championId
    }

    init(from decoder: Decoder) throws {

        let container = try decoder.container(keyedBy: responseKeys.self)

        let gameId = try container.decodeIfPresent(Int.self, forKey: .gameId)
        let championId = try container.decodeIfPresent(Int.self, forKey: .championId)

        self.gameId = gameId
        self.championId = championId
    }
}
