//
//  LikesReceivedCell.swift
//  LoLMatch
//
//  Created by Scarpz on 17/10/18.
//  Copyright © 2018 Matheus Garcia. All rights reserved.
//

import UIKit
import Nuke

protocol LikeUserDelegate: class {
    func displayAlert(title: String, message: String)
}

class LikesReceivedCell: UITableViewCell {
    
    // MARK: - Outlets
    // Lane Information
     @IBOutlet weak var lanesImages: DoubleImageView!
    
    // Elo Information
    @IBOutlet weak var eloImage: UIImageView!
    @IBOutlet weak var eloLabel: UILabel!
    @IBOutlet weak var pdlLabel: UILabel!
    
    // Last Champions Information
    @IBOutlet var championViews: [DoubleImageView]!
    @IBOutlet var championLabels: [UILabel]!
    @IBOutlet var kdaLabels: [UILabel]!
    
    
    // MARK: - Properties
    private var summonoerId: Int = -1
    weak var delegate: LikeUserDelegate?
    
    
    // MARK: - Methods
    func setup(user: User, delegate: LikeUserDelegate) {
        
        self.lanesImages.setInnerSpacing(forPrimaryView: 10, forSecondaryView: 5)
        self.lanesImages.setBackgroundColor(forPrimaryView: .clear, forSecondaryView: .customBlack)
        
        self.championViews.forEach({ $0.setInnerSpacing(forPrimaryView: 0, forSecondaryView: 3) })
        self.championViews.forEach({ $0.setBackgroundColor(forPrimaryView: .customBlack, forSecondaryView: .customBlack) })
        
        self.summonoerId = user.summonerId
        self.delegate = delegate
        self.lanesImages.primaryImage = user.lane1.image()
        self.lanesImages.secondaryImage = user.lane2.image()
        
        UserServices.getElo(byId: user.summonerId) { [unowned self] elos, error in
            
            // TODO: -
            if let validElos = elos {
                for elo in validElos where elo.queueType ?? "" == "RANKED_SOLO_5x5" {
                    
                    if let tier = elo.tier, let rank = elo.rank, let pdl = elo.pdl, let wins = elo.wins, let losses = elo.losses {
                        DispatchQueue.main.async {
                            self.eloImage.image = elo.image
                            self.eloLabel.text = "\(tier) \(rank)"
                            self.pdlLabel.text = "\(pdl) PDL | \(wins)W \(losses)L"
                        }
                    } else {
                        if let delegate = self.delegate {
                            delegate.displayAlert(title: "Oops...", message: "Erro ao pegar as informaçoes de elo do jogador")
                        }
                    }
                }
            }
        }
        
        UserServices.getPlayerKda(byId: user.accountId, numberOfMatches: 3) { (matches, error) in
            
            if let validMatches = matches {
                for index in 0..<validMatches.count {
                    let kda: (Int, Int, Int) = (validMatches[index].kill!, validMatches[index].death!, validMatches[index].assist!)
                    
                    let championId = validMatches[index].championId!
                    let champion = ChampionService.getChampion(by: championId)!
                    
                    let championURL = URL(string: champion.thumbUrl)!
                    
                    loadImage(with: championURL, into: self.championViews[index].primaryImageView)
                    self.championLabels[index].text = champion.name
                    self.kdaLabels[index].text = "\(kda.0) / \(kda.1) / \(kda.2)"
                }
            }
        }
    }
}
