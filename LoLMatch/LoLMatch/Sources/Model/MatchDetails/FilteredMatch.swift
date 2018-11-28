//
//  FilteredMatch.swift
//  LoLMatch
//
//  Created by Matheus Garcia on 08/11/18.
//  Copyright © 2018 Matheus Garcia. All rights reserved.
//

import UIKit

struct FilteredMatch {
    var kill: Int?
    var death: Int?
    var assist: Int?
    var championId: Int?
    var win: Bool?
    var champion: Champion?

    init(k: Int?, d: Int?, a: Int?, championId: Int?, win: Bool?, champion: Champion? = nil) {
        self.kill = k
        self.death = d
        self.assist = a
        self.championId = championId
        self.win = win
        self.champion = champion
    }
}
