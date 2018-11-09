//
//  MatchRiotResponse.swift
//  LoLMatch
//
//  Created by Matheus Garcia on 08/11/18.
//  Copyright © 2018 Matheus Garcia. All rights reserved.
//

import Foundation

struct MainStructForMatch: Codable {

    var matches: [MatchBasicInfo]
}

extension MainStructForMatch {

    enum matchKey: String, CodingKey {
        case matches
    }

    init(from decoder: Decoder) throws {

        let container = try decoder.container(keyedBy: matchKey.self)

        let matches = try container.decodeIfPresent([MatchBasicInfo].self, forKey: .matches) ?? []

        self.matches = matches
    }
}
