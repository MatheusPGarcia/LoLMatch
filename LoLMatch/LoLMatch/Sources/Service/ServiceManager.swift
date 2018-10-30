//
//  ServiceProvider.swift
//  LoLMatch
//
//  Created by Matheus Garcia on 16/10/18.
//  Copyright © 2018 Matheus Garcia. All rights reserved.
//

import Foundation
import Moya

class BaseServiceProvider: BaseService {

    static func getSummonerId(byName summonerName: String, completion: @escaping (UserIdProfile?, Error?) -> Void) {

        let target = RiotProvider.getUserId(summonerName: summonerName)

        request(provider: riotProvider, target: target, type: UserIdProfile.self, completion: completion)
    }
}
