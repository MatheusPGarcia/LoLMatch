//
//  UserIdProfile.swift
//  LoLMatch
//
//  Created by Matheus Garcia on 30/10/18.
//  Copyright © 2018 Matheus Garcia. All rights reserved.
//

import Foundation

struct UserIdProfile: Codable {

    var profileIconId: Int
    var name: String
    var accountId: Int
    var summonerId: Int
}

extension UserIdProfile {

    enum responseKeys: String, CodingKey {
        case profileIconId
        case name
        case accountId
        case id
    }

    init(from decoder: Decoder) throws {

        let container = try decoder.container(keyedBy: responseKeys.self)

        let profileIconId = try container.decode(Int.self, forKey: .profileIconId)
        let name = try container.decode(String.self, forKey: .name)
        let accountId = try container.decode(Int.self, forKey: .accountId)
        let summonerId = try container.decode(Int.self, forKey: .id)

        self.profileIconId = profileIconId
        self.name = name
        self.accountId = accountId
        self.summonerId = summonerId
    }
}
