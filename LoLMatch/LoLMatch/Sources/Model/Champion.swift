//
//  Champion.swift
//  LoLMatch
//
//  Created by Scarpz on 09/11/18.
//  Copyright © 2018 Matheus Garcia. All rights reserved.
//

import Foundation

struct Champion: Codable {
    var id: Int
    var stringId: String
    var name: String
    var thumbUrl: String
}


extension Champion {
    
    enum MainKeys: String, CodingKey {
        case data
    }
    
    enum ResponseKeys: String, CodingKey {
        case id = "key"
        case stringId = "id"
        case name
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: MainKeys.self)
        let nested = try container.nestedContainer(keyedBy: ResponseKeys.self, forKey: .data)
        
        let id = try nested.decode(Int.self, forKey: .id)
        let stringId = try nested.decode(String.self, forKey: .stringId)
        let name = try nested.decode(String.self, forKey: .name)

        self.id = id
        self.stringId = stringId
        self.name = name
        self.thumbUrl = "http://ddragon.leagueoflegends.com/cdn/\(Patch.patch)/img/champion/\(stringId).png"
        
    }
}
