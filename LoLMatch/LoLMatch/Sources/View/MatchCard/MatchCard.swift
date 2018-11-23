//
//  MatchCard.swift
//  LoLMatch
//
//  Created by Scarpz on 16/10/18.
//  Copyright © 2018 Matheus Garcia. All rights reserved.
//

import UIKit
import Nuke

@IBDesignable class MatchCard: UIView {
    
    @IBOutlet weak var swipeFeedbackImage: UIImageView!
    @IBOutlet weak var laneImageView: TripleImageView!
    @IBOutlet weak var lane1Label: UILabel!
    @IBOutlet weak var lane2Label: UILabel!
    @IBOutlet weak var eloImageView: RoundedImageView!
    @IBOutlet weak var tierLabel: UILabel!
    @IBOutlet weak var pdlLabel: UILabel!
    @IBOutlet weak var champion1ImageView: UIImageView!
    @IBOutlet weak var champion1NameLabel: UILabel!
    @IBOutlet weak var champion1Kda: UILabel!
    @IBOutlet weak var champion2ImageView: UIImageView!
    @IBOutlet weak var champion2NameLabel: UILabel!
    @IBOutlet weak var champion2Kda: UILabel!
    @IBOutlet weak var champion3ImageView: UIImageView!
    @IBOutlet weak var champion3NameLabel: UILabel!
    @IBOutlet weak var champion3Kda: UILabel!
    

    var view = self

    // MARK: - Properties
    // Content view of the XIB
    private var contentView: UIView?
    
    
    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupXib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupXib()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.setupXib()
    }

    func setupView(summoner: User) {
        
        self.laneImageView.setInnerSpacing(forPrimaryView: 5, forSecondaryView: 5)
        self.laneImageView.setBackgroundColor(forPrimaryView: .black, forSecondaryView: .black)

        self.laneImageView.primaryImageView.image = summoner.lane1.coloredImage()
        self.laneImageView.secondaryImageView.image = summoner.lane2.coloredImage()
        
        self.champion1ImageView.clipsToBounds = true
        self.champion2ImageView.clipsToBounds = true
        self.champion3ImageView.clipsToBounds = true
        
        self.lane1Label.text = summoner.lane1.description().uppercased()
        self.lane2Label.text = summoner.lane2.description().uppercased()

        UserServices.getElo(byId: summoner.summonerId) { [unowned self] elos, error in
            
            // TODO: -
            if let validElos = elos {
                for elo in validElos where elo.queueType ?? "" == "RANKED_SOLO_5x5" {
                    
                    if let tier = elo.tier, let rank = elo.rank, let pdl = elo.pdl, let wins = elo.wins, let losses = elo.losses {
                        DispatchQueue.main.async {
                            self.eloImageView.image = elo.image
                            self.tierLabel.text = "\(tier) \(rank)"
                            self.pdlLabel.text = "\(pdl) PDL | \(wins)W \(losses)L"
                        }
                    } else {
                        print("Error on getting elo")
                    }
                }
            }
        }

        UserServices.getPlayerKda(byId: summoner.accountId, numberOfMatches: 3) { (matches, error) in
            var matches = matches!
            var currentMatch = matches.first
            matches.removeFirst()

            var currentChampion = ChampionService.getChampion(by: currentMatch!.championId ?? -1)!
            
            var url = URL(string: currentChampion.thumbUrl)!
            loadImage(with: url, options: ImageLoadingOptions(placeholder: #imageLiteral(resourceName: "profileTabIcon"), transition: .fadeIn(duration: 0.3)), into: self.champion1ImageView)
            self.champion1ImageView.layer.borderColor = currentMatch!.win! ? UIColor.customGreen.cgColor : UIColor.customRed.cgColor
            self.champion1NameLabel.text = currentChampion.name
            self.champion1Kda.text = "\(currentMatch!.kill!)/\(currentMatch!.death!)/\(currentMatch!.assist!)"

            currentMatch = matches.first
            matches.removeFirst()

            currentChampion = ChampionService.getChampion(by: currentMatch!.championId ?? -1)!
            url = URL(string: currentChampion.thumbUrl)!
            self.champion2ImageView.layer.borderColor = currentMatch!.win! ? UIColor.customGreen.cgColor : UIColor.customRed.cgColor
            loadImage(with: url, options: ImageLoadingOptions(placeholder: #imageLiteral(resourceName: "profileTabIcon"), transition: .fadeIn(duration: 0.3)), into: self.champion2ImageView)
            currentChampion = ChampionService.getChampion(by: currentMatch!.championId ?? -1)!
            self.champion2NameLabel.text = currentChampion.name
            self.champion2Kda.text = "\(currentMatch!.kill!)/\(currentMatch!.death!)/\(currentMatch!.assist!)"

            currentMatch = matches.first
            matches.removeFirst()

            currentChampion = ChampionService.getChampion(by: currentMatch!.championId ?? -1)!
            url = URL(string: currentChampion.thumbUrl)!
            self.champion3ImageView.layer.borderColor = currentMatch!.win! ? UIColor.customGreen.cgColor : UIColor.customRed.cgColor
            loadImage(with: url, options: ImageLoadingOptions(placeholder: #imageLiteral(resourceName: "profileTabIcon"), transition: .fadeIn(duration: 0.3)), into: self.champion3ImageView)
            currentChampion = ChampionService.getChampion(by: currentMatch!.championId ?? -1)!
            self.champion3NameLabel.text = currentChampion.name
            self.champion3Kda.text = "\(currentMatch!.kill!)/\(currentMatch!.death!)/\(currentMatch!.assist!)"
        }


//        @IBOutlet weak var pdlLabel: UILabel!
//        @IBOutlet weak var champion1ImageView: DoubleImageView!
//        @IBOutlet weak var champion1NameLabel: UILabel!
//        @IBOutlet weak var champion1Kda: UILabel!
//        @IBOutlet weak var champion2ImageView: DoubleImageView!
//        @IBOutlet weak var champion2NameLabel: UILabel!
//        @IBOutlet weak var champion2Kda: UILabel!
//        @IBOutlet weak var champion3ImageView: DoubleImageView!
//        @IBOutlet weak var champion3NameLabel: UILabel!
//        @IBOutlet weak var champion3Kda: UILabel!
    }
    
}

extension MatchCard {
    
    // MARK: - XIB functions
    
    /// Instantiate the view defined in a xib file using the same name of the class
    ///
    /// - Returns: the first view found in the xib or nil if it was unable to find any view
    func loadViewFromXib() -> UIView? {
        
        let bundle = Bundle(for: type(of: self))
        
        // load the xib from the main bundle
        let xib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        
        // load the view inside the xib
        return xib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
    /// Loads the xib, associates it to the contentView and add it to the view's hierarchy
    func setupXib() {
        // only load the xib if the contentView is not loaded yet
        if self.contentView == nil {
            // load content view from xib
            
            // if it has failed, this example needs to be rewriten
            guard let contentView = loadViewFromXib() else {
                fatalError("Can't load the view from \(String(describing: type(of: self))).xib")
            }
            
            // adjust the contentView to have the same size of the view itself
            contentView.frame = bounds
            
            // let the content view adjusts automatically for flexible size (width and height)
            contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            
            // add content view to the view hierarchy
            self.addSubview(contentView)
            
            self.contentView = contentView
        }
    }
}
