//
//  ServiceProvider.swift
//  LoLMatch
//
//  Created by Matheus Garcia on 16/10/18.
//  Copyright © 2018 Matheus Garcia. All rights reserved.
//

import Foundation
import Moya

class BaseServiceProvider {

    static func getSummonerId(byName summonerName: String) {

        riotProvider.request(.getUserId(summonerName: summonerName)) { (response) in

            response.map(<#T##transform: (Response) -> U##(Response) -> U#>)

        }
    }
}
