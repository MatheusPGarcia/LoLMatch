//
//  MatchCell.swift
//  LoLMatch
//
//  Created by Scarpz on 07/11/18.
//  Copyright © 2018 Matheus Garcia. All rights reserved.
//

import UIKit
import Nuke

class MatchCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var summonerImages: TripleImageView!
    @IBOutlet weak var summonerNameLabel: UILabel!
    @IBOutlet weak var eloImageView: UIImageView!
    @IBOutlet weak var eloLabel: UILabel!
    @IBOutlet weak var pdlLabel: UILabel!
    
    
    // MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    // MARK: - Methods
    func setup(user: User) {
        
        self.summonerImages.setInnerSpacing(forPrimaryView: 0, forSecondaryView: 4, forTerciaryView:  3)
        self.summonerImages.setBackgroundColor(forPrimaryView: .black, forSecondaryView: .black, forTerciaryView: .black)
        self.summonerImages.secondaryImageView.image = user.lane1.coloredImage()
        self.summonerImages.terciaryImageView.image = user.lane2.coloredImage()
        
        self.summonerNameLabel.text = user.summonerName.uppercased()

        self.setupElo(summonerId: user.summonerId)
        self.setupProfileIcon(profileIconId: user.profileIconId)
    }
    
    
    // MARK: - Private Methods
    private func setupElo(summonerId: Int) {
        UserServices.getElo(byId: summonerId) { [unowned self] elos, error in
            
            if let validElos = elos {
                for elo in validElos where elo.queueType ?? "" == "RANKED_SOLO_5x5" {
                    if let tier = elo.tier, let rank = elo.rank, let pdl = elo.pdl, let wins = elo.wins, let losses = elo.losses {
                        DispatchQueue.main.async {
                            self.eloImageView.image = elo.image
                            self.eloLabel.text = "\(tier) \(rank)"
                            self.pdlLabel.text = "\(pdl) PDL | \(wins)W \(losses)L"
                        }
                    } else {
                        print("Error on getting elo")
                    }
                }
            }
        }
    }
    
    private func setupProfileIcon(profileIconId: Int) {
        
        // TODO: -
        let imageURL = URL(string: "http://ddragon.leagueoflegends.com/cdn/\(Patch.patch)/img/profileicon/\(profileIconId).png")!
        
        loadImage(with: imageURL, options: ImageLoadingOptions(placeholder: #imageLiteral(resourceName: "profilePlaceholder"),transition: .fadeIn(duration: 0.3)), into: self.summonerImages.primaryImageView)
    }

}
