//
//  RiotService.swift
//  LoLMatch
//
//  Created by Matheus Garcia on 16/10/18.
//  Copyright © 2018 Matheus Garcia. All rights reserved.
//

import Moya

let riotProvider = MoyaProvider<RiotService>()

enum RiotService {
    case getUserId(summonerName: String)
}

extension RiotService: TargetType {
    var baseURL: URL {
        guard let url = URL(string: "https://br1.api.riotgames.com/lol/") else { fatalError("Failed to get base url") }
        return url
    }

    var path: String {
        switch self {
        case .getUserId(let summonerName):
            return "summoner/v3/summoners/by-name/\(summonerName)"
        }
    }

    var method: Method {
        return .get
    }

    var sampleData: Data {
        return "sample data".data(using: .utf8)!
    }

    var task: Task {
        switch self {
        case .getUserId:
            return .requestPlain
        }
    }

    var headers: [String : String]? {
        switch self {
        case .getUserId:
            return ["X-Riot-Token" : "\(Credentials.riotKey)"]
        }
    }
}
