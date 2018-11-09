//
//  LikesReceivedCell.swift
//  LoLMatch
//
//  Created by Scarpz on 17/10/18.
//  Copyright © 2018 Matheus Garcia. All rights reserved.
//

import UIKit

protocol LikeUserDelegate: class {
    func likeUser(summonerId: Int)
    func dislikeUser(summonerId: Int)
    func displayAlert(title: String, message: String)
}

class LikesReceivedCell: UITableViewCell {
    
    // MARK: - Outlets
    // Lane Information
    @IBOutlet weak var lanesView: DoubleImageView!
    @IBOutlet weak var primaryLaneLabel: UILabel!
    @IBOutlet weak var secondaryLaneLabel: UILabel!
    
    // Elo Information
    @IBOutlet weak var eloImage: RoundedImageView!
    @IBOutlet weak var eloLabel: UILabel!
    @IBOutlet weak var pdlLabel: UILabel!
    
    // Last Champions Information
    @IBOutlet var championViews: [DoubleImageView]!
    @IBOutlet var championLabels: [UILabel]!
    @IBOutlet var kdaLabels: [UILabel]!
    
    
    // MARK: - Properties
    private var summonoerId: Int = -1
    weak var delegate: LikeUserDelegate?
    
    
    // MARK: - Actions
    @IBAction func likeUser(_ sender: UIButton) {
        if let delegate = self.delegate {
            delegate.likeUser(summonerId: self.summonoerId)
        }
    }
    
    @IBAction func dislikeUser(_ sender: UIButton) {
        if let delegate = self.delegate {
            delegate.dislikeUser(summonerId: self.summonoerId)
        }
    }
    
    
    // MARK: - Methods
    func setup(user: User, delegate: LikeUserDelegate) {
        self.summonoerId = user.summonerId
        self.delegate = delegate
        self.primaryLaneLabel.text = user.lane1.description()
        self.secondaryLaneLabel.text = user.lane2.description()
        self.lanesView.primaryImageView.image = user.lane1.image()
        self.lanesView.secondaryImageView.image = user.lane2.image()
        
        UserServices.getElo(byId: user.summonerId) { [unowned self] elos, error in
            
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
    }
}
