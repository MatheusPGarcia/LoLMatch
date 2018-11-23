//
//  ProfileLastMatchesCell.swift
//  LoLMatch
//
//  Created by Scarpz on 16/11/18.
//  Copyright © 2018 Matheus Garcia. All rights reserved.
//

import UIKit
import Nuke

class ProfileLastMatchesCell: UITableViewCell {

    
    // MARK: - Outlets
    @IBOutlet var championViews: [UIImageView]!
    @IBOutlet var championLabels: [UILabel]!
    @IBOutlet var kdaLabels: [UILabel]!
    
    
    // MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    // MARK - Methods
    func setup(user: User) {
        
        UserServices.getPlayerKda(byId: user.accountId, numberOfMatches: 3) { (matches, error) in
            
            if let validMatches = matches {
                
                for index in 0..<validMatches.count {
                    let kda: (Int, Int, Int) = (validMatches[index].kill!, validMatches[index].death!, validMatches[index].assist!)
                    
                    self.championViews[index].clipsToBounds = true
                    self.championViews[index].layer.borderColor = validMatches[index].win! ? UIColor.customGreen.cgColor : UIColor.customRed.cgColor
                    
                    let championId = validMatches[index].championId!
                    let champion = ChampionService.getChampion(by: championId)!
                    
                    let championURL = URL(string: champion.thumbUrl)!
                    
                    loadImage(with: championURL, options: ImageLoadingOptions(placeholder: #imageLiteral(resourceName: "profileTabIcon"), transition: .fadeIn(duration: 0.3)), into: self.championViews[index])
                    self.championLabels[index].text = champion.name
                    self.kdaLabels[index].text = "\(kda.0) / \(kda.1) / \(kda.2)"
                }
            }
        }
    }
        
    
}
