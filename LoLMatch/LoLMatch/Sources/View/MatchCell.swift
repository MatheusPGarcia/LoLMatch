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
    @IBOutlet weak var primaryLaneImageView: UIImageView!
    @IBOutlet weak var primaryLaneLabel: UILabel!
    @IBOutlet weak var secondaryLaneImageView: UIImageView!
    @IBOutlet weak var secondaryLaneLabel: UILabel!
    @IBOutlet weak var eloLabel: UILabel!
    
    
    // MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    // MARK: - Methods
    func setup(user: User) {
        
        self.summonerImages.setInnerSpacing(forPrimaryView: 0, forSecondaryView: 4, forTerciaryView:  3)
        self.summonerImages.setBackgroundColor(forPrimaryView: .black, forSecondaryView: .black, forTerciaryView: .black)
        
        self.summonerNameLabel.text = user.summonerName
        
        
        self.primaryLaneLabel.text = user.lane1.description()
        self.summonerImages.secondaryImageView.image = user.lane1.coloredImage()
        self.secondaryLaneLabel.text = user.lane2.description()
        self.summonerImages.terciaryImageView.image = user.lane2.coloredImage()
        
        self.setupElo(summonerId: user.summonerId)
        self.setupProfileIcon(profileIconId: user.profileIconId)
    }
    
    
    // MARK: - Private Methods
    private func setupElo(summonerId: Int) {
        UserServices.getElo(byId: summonerId) { [unowned self] elos, error in
            
            if let validElos = elos {
                for elo in validElos where elo.queueType ?? "" == "RANKED_SOLO_5x5" {
                    self.eloLabel.text = "\(elo.tier ?? "") \(elo.rank ?? "")"
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
