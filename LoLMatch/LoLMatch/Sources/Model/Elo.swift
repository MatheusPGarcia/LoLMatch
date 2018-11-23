//
//  Elo.swift
//  LoLMatch
//
//  Created by Matheus Garcia on 01/11/18.
//  Copyright © 2018 Matheus Garcia. All rights reserved.
//

import UIKit

struct Elo: Codable {

    var queueType: String?
    var pdl: Int?
    var rank: String?
    var tier: String?
    var wins: Int?
    var losses: Int?
}

extension Elo {

    enum responseKeys: String, CodingKey {
        case queueType
        case pdl = "leaguePoints"
        case rank
        case tier
        case wins
        case losses
    }

    init(from decoder: Decoder) throws {

        let container = try decoder.container(keyedBy: responseKeys.self)

        let queueType = try container.decodeIfPresent(String.self, forKey: .queueType)
        let pdl = try container.decodeIfPresent(Int.self, forKey: .pdl)
        let rank = try container.decodeIfPresent(String.self, forKey: .rank)
        let tier = try container.decodeIfPresent(String.self, forKey: .tier)
        let wins = try container.decodeIfPresent(Int.self, forKey: .wins)
        let losses = try container.decodeIfPresent(Int.self, forKey: .losses)

        self.queueType = queueType
        self.pdl = pdl
        self.rank = rank
        self.tier = tier
        self.wins = wins
        self.losses = losses
    }
}

extension Elo {
    
    var image: UIImage {
        let eloTier = "\(self.tier ?? "") \(self.rank ?? "")"
        
        switch eloTier {
        case "BRONZE V":
            return #imageLiteral(resourceName: "bronze_v")
        case "BRONZE IV":
            return #imageLiteral(resourceName: "bronze_iv")
        case "BRONZE III":
            return #imageLiteral(resourceName: "bronze_iii")
        case "BRONZE II":
            return #imageLiteral(resourceName: "bronze_ii")
        case "BRONZE I":
            return #imageLiteral(resourceName: "bronze_i")
        case "SILVER V":
            return #imageLiteral(resourceName: "silver_v")
        case "SILVER IV":
            return #imageLiteral(resourceName: "silver_iv")
        case "SILVER III":
            return #imageLiteral(resourceName: "silver_iii")
        case "SILVER II":
            return #imageLiteral(resourceName: "silver_ii")
        case "SILVER I":
            return #imageLiteral(resourceName: "silver_i")
        case "GOLD V":
            return #imageLiteral(resourceName: "gold_v")
        case "GOLD IV":
            return #imageLiteral(resourceName: "gold_iv")
        case "GOLD III":
            return #imageLiteral(resourceName: "gold_iii")
        case "GOLD II":
            return #imageLiteral(resourceName: "gold_ii")
        case "GOLD I":
            return #imageLiteral(resourceName: "gold_i")
        case "PLATINUM V":
            return #imageLiteral(resourceName: "platinum_v")
        case "PLATINUM IV":
            return #imageLiteral(resourceName: "platinum_iv")
        case "PLATINUM III":
            return #imageLiteral(resourceName: "platinum_iii")
        case "PLATINUM II":
            return #imageLiteral(resourceName: "platinum_ii")
        case "PLATINUM I":
            return #imageLiteral(resourceName: "platinum_i")
        case "DIAMOND V":
            return #imageLiteral(resourceName: "diamond_v")
        case "DIAMOND IV":
            return #imageLiteral(resourceName: "diamond_iv")
        case "DIAMOND III":
            return #imageLiteral(resourceName: "diamond_iii")
        case "DIAMOND II":
            return #imageLiteral(resourceName: "diamond_ii")
        case "DIAMOND I":
            return #imageLiteral(resourceName: "diamond_i")
        case "MASTER I":
            return #imageLiteral(resourceName: "master")
        case "CHALLENGER I":
            return #imageLiteral(resourceName: "challenger")
        default:
            return #imageLiteral(resourceName: "unranked")
        }
    }
    
    var rankImage: UIImage? {
        switch self.rank ?? "" {
        case "I":
            return #imageLiteral(resourceName: "I")
        case "II":
            return #imageLiteral(resourceName: "II")
        case "III":
            return #imageLiteral(resourceName: "III")
        case "IV":
            return #imageLiteral(resourceName: "IV")
        case "V":
            return #imageLiteral(resourceName: "V")
        default:
            return nil
        }
    }
}
