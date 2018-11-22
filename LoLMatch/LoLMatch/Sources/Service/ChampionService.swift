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
    
    
    static func getChampionList(completion: @escaping ([Champion]?, Error?) -> Void) {
        
        if let localChampions = UserDefaultsManager.getChampionList() {
            completion(localChampions, nil)
        } else {
            let target = DataDragonProvider.getChampionList
            
            request(provider: dataDragonProvider, target: target, type: [Champion].self, completion: completion)
        }
    }
    
}
