//
//  CardService.swift
//  LoLMatch
//
//  Created by Matheus Garcia on 22/11/18.
//  Copyright © 2018 Matheus Garcia. All rights reserved.
//

import UIKit

class CardService {

    static private let dispatchGroup = DispatchGroup()

    static func getCardDetail(forUser user: User, completion: @escaping (CardViewModel) -> Void) {

        let summonerIconId = user.profileIconId
        let lane1 = user.lane1
        let lane2 = user.lane2
        var tierImage: UIImage?
        var tier = ""
        var pdl = ""
        var matches = [FilteredMatch]()

        dispatchGroup.enter()
        UserServices.getElo(byId: user.summonerId) { (response, error) in
            guard error == nil, let response = response else { return }
            guard let tierString = response.first?.tier,
                  let pdlString = response.first?.pdl,
                  let winString = response.first?.wins,
                  let losesString = response.first?.losses else { return }

            tierImage = response.first?.image
            tier = String(format: String.tierText, tierString)
            pdl = String(format: String.pdlText, pdlString, winString, losesString)

            dispatchGroup.leave()
        }

        dispatchGroup.enter()
        UserServices.getPlayerKda(byId: user.accountId, numberOfMatches: 3) { (response, error) in
            guard error == nil, let response = response else { return }

            matches = response
            dispatchGroup.leave()
        }

        dispatchGroup.notify(queue: .main) {
            let newCardViewModel = CardViewModel(summonerIconId: summonerIconId,
                                                 lane1: lane1,
                                                 lane2: lane2,
                                                 tierImage: tierImage,
                                                 tier: tier,
                                                 pdl: pdl,
                                                 lastMatches: matches)

            completion(newCardViewModel)
        }
    }
}
