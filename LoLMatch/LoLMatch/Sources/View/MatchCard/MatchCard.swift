//
//  MatchCard.swift
//  LoLMatch
//
//  Created by Scarpz on 16/10/18.
//  Copyright © 2018 Matheus Garcia. All rights reserved.
//

import UIKit
import Nuke

protocol matchCardDelegate: class {

    func updateCard()
}

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

    private var delegate: matchCardDelegate?

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

    func setupView(summoner: User, currentUserTier: String, delegate: matchCardDelegate) {

        self.delegate = delegate

        CardService.getCardDetail(forUser: summoner) { (cardViewModel) in

            guard self.checkElo(cardViewModel, currentUserTier: currentUserTier) else {
                return
            }

            // Summoners setup
            self.laneImageView.setInnerSpacing(forPrimaryView: 5, forSecondaryView: 5)
            self.laneImageView.setBackgroundColor(forPrimaryView: .black, forSecondaryView: .black)

            self.laneImageView.primaryImageView.image = summoner.lane1.coloredImage()
            self.laneImageView.secondaryImageView.image = summoner.lane2.coloredImage()

            self.champion1ImageView.clipsToBounds = true
            self.champion2ImageView.clipsToBounds = true
            self.champion3ImageView.clipsToBounds = true

            // Response setup

            self.eloImageView.image = cardViewModel.tierImage

            self.lane1Label.text = summoner.lane1.description().uppercased()
            self.lane2Label.text = summoner.lane2.description().uppercased()

            self.lane1Label.text = cardViewModel.lane1.description()
            self.lane2Label.text = cardViewModel.lane2.description()

            self.tierLabel.text = cardViewModel.tier
            self.pdlLabel.text = cardViewModel.pdl

            var match = cardViewModel.lastMatches[0]
            var kdaDescription = String(format: String.kdaText, match.kill!, match.death!, match.assist!)
            self.champion1Kda.text = kdaDescription
            self.champion1NameLabel.text = match.champion?.name
            if let thumbUrl = match.champion?.thumbUrl {
                let url = URL(string: thumbUrl)!
                loadImage(with: url, options: ImageLoadingOptions(placeholder: #imageLiteral(resourceName: "championPlaceholder"), transition: .fadeIn(duration: 0.3)), into: self.champion1ImageView)
            }

            match = cardViewModel.lastMatches[1]
            kdaDescription = String(format: String.kdaText, match.kill!, match.death!, match.assist!)
            self.champion2Kda.text = kdaDescription
            self.champion2NameLabel.text = match.champion?.name
            if let thumbUrl = match.champion?.thumbUrl {
                let url = URL(string: thumbUrl)!
                loadImage(with: url, options: ImageLoadingOptions(placeholder: #imageLiteral(resourceName: "championPlaceholder"), transition: .fadeIn(duration: 0.3)), into: self.champion2ImageView)
            }

            match = cardViewModel.lastMatches[2]
            kdaDescription = String(format: String.kdaText, match.kill!, match.death!, match.assist!)
            self.champion3Kda.text = kdaDescription
            self.champion3NameLabel.text = match.champion?.name
            if let thumbUrl = match.champion?.thumbUrl {
                let url = URL(string: thumbUrl)!
                loadImage(with: url, options: ImageLoadingOptions(placeholder: #imageLiteral(resourceName: "championPlaceholder"), transition: .fadeIn(duration: 0.3)), into: self.champion3ImageView)
            }

            // remove blur
            UIView.animate(withDuration: 0.4, animations: {
                self.swipeFeedbackImage.alpha = 0
            })
        }
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

// MARK: - Private methods
extension MatchCard {

    private func checkElo(_ cardViewModel: (CardViewModel), currentUserTier: String) -> Bool {

        switch currentUserTier {
        case "BRONZE":
            if cardViewModel.tier != "BRONZE" && cardViewModel.tier != "SILVER" {
                self.delegate?.updateCard()
                return false
            }
            break
        case "SILVER":
            if cardViewModel.tier != "BRONZE" && cardViewModel.tier != "SILVER" && cardViewModel.tier != "GOLD" {
                self.delegate?.updateCard()
                return false
            }
            break
        case "GOLD":
            if cardViewModel.tier != "SILVER" && cardViewModel.tier != "GOLD" && cardViewModel.tier != "PLATINUM" {
                self.delegate?.updateCard()
                return false
            }
            break
        case "PLATINUM":
            if cardViewModel.tier != "GOLD" && cardViewModel.tier != "PLATINUM" && cardViewModel.tier != "DIAMOND" {
                self.delegate?.updateCard()
                return false
            }
            break
        case "DIAMOND":
            if cardViewModel.tier != "PLATINUM" && cardViewModel.tier != "DIAMOND" && cardViewModel.tier != "MASTER" {
                self.delegate?.updateCard()
                return false
            }
            break
        case "MASTER":
            if cardViewModel.tier != "DIAMOND" && cardViewModel.tier != "MASTER" && cardViewModel.tier != "CHALLENGER" {
                self.delegate?.updateCard()
                return false
            }
            break
        case "CHALLENGER":
            if cardViewModel.tier != "MASTER" && cardViewModel.tier != "CHALLENGER" {
                self.delegate?.updateCard()
                return false
            }
        default:
            return true
        }

        return true
    }
}
