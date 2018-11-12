//
//  MatchViewController.swift
//  LoLMatch
//
//  Created by Matheus Garcia on 24/10/18.
//  Copyright © 2018 Matheus Garcia. All rights reserved.
//

import UIKit

class MatchViewController: UIViewController {

    @IBOutlet private weak var cardView: MatchCard!

    private var cardCenter: CGPoint?

    override func viewDidLoad() {
        super.viewDidLoad()

        FeedService.getFeed { (feedUsers) in
            guard let user = feedUsers?.first else { return }
            self.cardView.setupView(summoner: user)
        }
        cardCenter = cardView.center
        
        ChampionService.getChampionList { champions, error in
            if let champions = champions {
                print("x")
            }
        }
    }

    @IBAction func matchCardPressed(_ sender: UIPanGestureRecognizer) {

        guard let cardReference = sender.view as? MatchCard else { return }

        let card = sender.view!
        let point = sender.translation(in: view)

        let xDistanceFromCenter = card.center.x - view.center.x

        let xPoint = view.center.x + point.x
        let yPoint = view.center.y + point.y
        card.center = CGPoint(x: xPoint, y: yPoint)

        updateFeedbackImageForCard(cardReference, distance: xDistanceFromCenter)

        if sender.state == UIGestureRecognizer.State.ended {

            if xDistanceFromCenter > 150 {
                FirebaseManager.likeUser(currentSummonerId: 2584566, summonerId: 2017255, completion: { _ in
                    print("Ok")
                })
//                UserServices.likeUser(summonerId: , completion: <#T##((Bool) -> Void)##((Bool) -> Void)##(Bool) -> Void#>)
                sendViewAway(cardReference, like: true)
            } else if xDistanceFromCenter < -150 {
                sendViewAway(cardReference, like: false)
            } else {
                resetCardPositionFor(cardReference)
            }
        }
    }
}

// MARK: - private methods
extension MatchViewController {

    private func updateFeedbackImageForCard(_ card: MatchCard, distance: CGFloat) {

        guard let image = card.swipeFeedbackImage else { return }

        if distance > 0 {
            image.image = UIImage(named: "like")
        } else {
            image.image = UIImage(named: "dislike")
        }

        image.alpha = abs(distance) / view.center.x
    }

    private func sendViewAway(_ card: MatchCard, like: Bool) {

        var sendTo: CGFloat = 500
        if !like {
            sendTo = -500
        }

        UIView.animate(withDuration: 0.4) {
            card.center = CGPoint(x: sendTo, y: card.center.y)
        }
    }

    private func resetCardPositionFor(_ card: MatchCard) {

        UIView.animate(withDuration: 0.4) {
            guard let cardCenter = self.cardCenter else { return }
            card.center = cardCenter
            card.swipeFeedbackImage.alpha = 0
        }
    }
}
