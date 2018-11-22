//
//  CardViewModel.swift
//  LoLMatch
//
//  Created by Matheus Garcia on 22/11/18.
//  Copyright © 2018 Matheus Garcia. All rights reserved.
//

import Foundation

struct CardViewModel {

    let summonerIconId: Int
    let lane1: Lane
    let lane2: Lane
    let tierImageUrl: String?
    let tier: String
    let pdl: String
    let lastMatches: [FilteredMatch]

    init (summonerIconId: Int, lane1: Lane, lane2: Lane, tierImageUrl: String?, tier: String, pdl: String, lastMatches: [FilteredMatch]) {
        self.summonerIconId = summonerIconId
        self.lane1 = lane1
        self.lane2 = lane2
        self.tierImageUrl = tierImageUrl
        self.tier = tier
        self.pdl = pdl
        self.lastMatches = lastMatches
    }
}
