//
//  RiotProvider.swift
//  LoLMatch
//
//  Created by Matheus Garcia on 16/10/18.
//  Copyright © 2018 Matheus Garcia. All rights reserved.
//

import Moya

let riotProvider = MoyaProvider<RiotProvider>(plugins: basePlugin)

let basePlugin: [PluginType] = [LoggerPlugin()]

enum RiotProvider {
    case getUserId(summonerName: String)
    case getElo(summonerId: Int)
    case getMatchList(accountId: Int, endIndex: Int)
    case getMatchDetails(matchId: Int)
}

extension RiotProvider: TargetType {
    var baseURL: URL {
        guard let url = URL(string: "https://br1.api.riotgames.com/lol") else { fatalError("Failed to get base url") }
        return url
    }

    var path: String {
        switch self {
        case .getUserId(let summonerName):
            return "summoner/v3/summoners/by-name/\(summonerName)"
        case .getElo(let summonerId):
            return "league/v3/positions/by-summoner/\(summonerId)"
        case .getMatchList(let accountId, _):
            return "match/v3/matchlists/by-account/\(accountId)"
        case .getMatchDetails(let matchId):
            return "match/v3/matches/\(matchId)"
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
        case .getUserId,
             .getElo,
             .getMatchList,
             .getMatchDetails:
            return .requestPlain
        }
    }

    var headers: [String : String]? {
        switch self {
        case .getUserId,
             .getElo,
             .getMatchDetails:
            return ["X-Riot-Token" : "\(Credentials.riotKey)"]
        case .getMatchList(_, let endIndex):
            return ["X-Riot-Token" : "\(Credentials.riotKey)",
                    "endInhdex" : String(endIndex)]
        }
    }
}
