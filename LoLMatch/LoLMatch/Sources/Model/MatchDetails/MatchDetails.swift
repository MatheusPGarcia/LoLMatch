//
//  MatchDetails.swift
//  LoLMatch
//
//  Created by Matheus Garcia on 08/11/18.
//  Copyright © 2018 Matheus Garcia. All rights reserved.
//

import Foundation

struct MatchDetails: Codable {

    var participantIdentities: [PlayerInMatch]
    var participants: [Stats]
}

extension MatchDetails {

    enum mainKeys: String, CodingKey {
        case participantIdentities
        case participants
    }

    init(from decoder: Decoder) throws {

        let container = try decoder.container(keyedBy: mainKeys.self)

        let participantIdentities = try container.decodeIfPresent([PlayerInMatch].self, forKey: .participantIdentities) ?? []
        let participants = try container.decodeIfPresent([Stats].self, forKey: .participants) ?? []

        self.participantIdentities = participantIdentities
        self.participants = participants
    }
}
