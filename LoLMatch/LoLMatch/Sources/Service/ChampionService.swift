//
//  ChampionService.swift
//  LoLMatch
//
//  Created by Scarpz on 09/11/18.
//  Copyright © 2018 Matheus Garcia. All rights reserved.
//

import Foundation

class ChampionService: BaseService {
    
    static func saveChampionList(champions: [Champion]?) {
        UserDefaultsManager.setChampionList(champions: champions)
    }
    
    
    static func getChampion(by id: Int) -> Champion? {
        if let champions = UserDefaultsManager.getChampionList() {
            return champions.first(where: { $0.id == id })
        } else {
            return nil
        }
    }
    
    
    static func getChampionList(completion: @escaping ([Champion]?, Error?) -> Void) {
        
        if let localChampions = UserDefaultsManager.getChampionList() {
            completion(localChampions, nil)
        } else {
//            let target = DataDragonProvider.getChampionList
//
//            request(provider: dataDragonProvider, target: target, type: [Champion].self, completion: completion)
            
            // TODO: - DELETE THIS WHEN MOYA WORKS
            ScarpzRequest.request(url: "http://ddragon.leagueoflegends.com/cdn/\(Patch.patch)/data/pt_BR/champion.json", body: nil, headers: nil) { response, error in
                if let response = response {
                    let championsJson = response["data"] as! [String : Any]
                    
                    var allChampions = [Champion]()
                    
                    for key in championsJson.keys {
                        let championJson = championsJson[key] as! [String : Any]
                        let id = championJson["key"] as! String
                        let stringId = championJson["id"] as! String
                        let name = championJson["name"] as! String
                        let thumbUrl = "http://ddragon.leagueoflegends.com/cdn/\(Patch.patch)/img/champion/\(stringId).png"
                        
                        allChampions.append(Champion(id: Int(id)!, stringId: stringId, name: name, thumbUrl: thumbUrl))
                    }
                    completion(allChampions, nil)
                    UserDefaultsManager.setChampionList(champions: allChampions)
                }
            }
        }
    }
    
}
