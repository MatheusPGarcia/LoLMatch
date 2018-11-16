//
//  ProfileInfoCell.swift
//  LoLMatch
//
//  Created by Scarpz on 16/11/18.
//  Copyright © 2018 Matheus Garcia. All rights reserved.
//

import UIKit
import Nuke

class ProfileInfoCell: UITableViewCell {

    
    // MARK: - Outlets
    @IBOutlet private weak var profileImages: TripleImageView!
    @IBOutlet private weak var summonerName: UILabel!
    
    
    // MARK: - Properties
    private weak var delegate: CellDelegate?
    
    // MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    // MARK: - Methods
    func setup(user: User, delegate: CellDelegate) {
        
        self.profileImages.setInnerSpacing(forPrimaryView: 0, forSecondaryView: 5, forTerciaryView: 5)
        
        self.delegate = delegate
        
        self.summonerName.text = user.summonerName.uppercased()
        
        // TODO: -
        let imageURL = URL(string: "http://ddragon.leagueoflegends.com/cdn/\(Patch.patch)/img/profileicon/\(user.profileIconId).png")!
        
        loadImage(with: imageURL, options: ImageLoadingOptions(placeholder: #imageLiteral(resourceName: "profilePlaceholder"),transition: .fadeIn(duration: 0.3)), into: self.profileImages.primaryImageView)
        
        UserServices.getElo(byId: user.summonerId) { [unowned self] elos, error in
            if let validElos = elos {
                
                for elo in validElos where elo.queueType ?? "" == "RANKED_SOLO_5x5" {
                    
                    if let tier = elo.tier, let rank = elo.rank {
                        
                        self.profileImages.secondaryImageView.image = elo.image
                        // TODO: - PUT THE ELO RANK IMAGE BELOW (I, II, III, IV, V)
                        self.profileImages.terciaryImageView.image = elo.image
                        
                    } else {
                        self.delegate?.displayAlert(title: "Oops...", message: "Erro ao pegar informações do Elo.")
                    }
                }
            } else {
                self.delegate?.displayAlert(title: "Oops...", message: "Erro ao pegar informações do Elo.")
            }
        }
    }

}
