//
//  MatchCell.swift
//  LoLMatch
//
//  Created by Scarpz on 07/11/18.
//  Copyright © 2018 Matheus Garcia. All rights reserved.
//

import UIKit

class MatchCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var summonerProfileImageView: UIImageView!
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
        self.summonerNameLabel.text = user.summonerName
        self.primaryLaneImageView.image = user.lane1.image()
        self.primaryLaneLabel.text = user.lane1.description()
        self.secondaryLaneImageView.image = user.lane2.image()
        self.secondaryLaneLabel.text = user.lane2.description()
        
        UserServices.getElo(byId: user.summonerId) { [unowned self] elos, error in
            
            if let validElos = elos {
                for elo in validElos where elo.queueType ?? "" == "RANKED_SOLO_5x5" {
                    self.eloLabel.text = "\(elo.tier ?? "") \(elo.rank ?? "")"
                }
            }
        }
    }

}
