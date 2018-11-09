//
//  DataDragonProvider.swift
//  LoLMatch
//
//  Created by Scarpz on 09/11/18.
//  Copyright © 2018 Matheus Garcia. All rights reserved.
//

import Moya

let dataDragonProvider = MoyaProvider<DataDragonProvider>(plugins: basePlugin)

enum DataDragonProvider {
    case getChampionList
}

extension DataDragonProvider: TargetType {
    var baseURL: URL {
        guard let url = URL(string: "http://ddragon.leagueoflegends.com/cdn/\(Patch.patch)/data/pt_BR/champion.json") else { fatalError("Failed to get base url") }
        return url
    }
    
    var path: String {
        return ""
    }
    
    var method: Method {
        return .get
    }
    
    var sampleData: Data {
        return "sample data".data(using: .utf8)!
    }
    
    var task: Task {
        return .requestPlain
    }
    
    var headers: [String : String]? {
        return nil
    }
}
