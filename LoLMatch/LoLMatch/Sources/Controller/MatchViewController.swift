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
    private var currentUserElo: String?

    private var cards =  [User]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupMatchView()
        self.getFeed()

        guard let currentUserId = UserServices.getCurrentUser()?.summonerId else { return }
        UserServices.getElo(byId: currentUserId) { [weak self] (eloArray, error) in
            guard let self = self else { return }

            guard let elo = eloArray?.first(where: { $0.queueType == "RANKED_SOLO_5x5" }) else { return }
            self.currentUserElo = elo.tier
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
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
                changeViewAfterInteraction(cardReference, like: true)
            } else if xDistanceFromCenter < -150 {
                changeViewAfterInteraction(cardReference, like: false)
            } else {
                resetCardPositionFor(cardReference)
            }
        }
    }

    @IBAction func updateCardTest(_ sender: Any) {
        self.updateCardUser()
    }
}

// MARK: - private methods
extension MatchViewController {
    
    private func setupMatchView() {
        self.cardCenter = self.cardView.center
        self.cardView.laneImageView.setInnerSpacing(forPrimaryView: 10, forSecondaryView: 10)
    }
    
    private func getFeed() {
        
        FeedService.getFeed { (feedUsers) in
            guard let feedUsers = feedUsers else { return }
            self.filterFeed(feedUsers)
            self.updateCardUser()
        }
    }

    private func updateCardUser() {
        guard let user = cards.first, let currentUserElo = currentUserElo else { return }
        cardView.setupView(summoner: user, currentUserTier: currentUserElo, delegate: self)
        cards.removeFirst()

        guard let cardCenter = cardCenter else { return }
        cardView.center = cardCenter
    }

    private func filterFeed(_ currentUsers: [User]) {

        let selfUser = UserServices.getCurrentUser()
        let filteredUsers = currentUsers.filter { $0.summonerId != selfUser?.summonerId }
        self.cards = filteredUsers
    }

    private func updateFeedbackImageForCard(_ card: MatchCard, distance: CGFloat) {

        if distance > 0 {
            card.swipeFeedbackImage.image = UIImage(named: "likeStamp")
        } else {
            card.swipeFeedbackImage.image = UIImage(named: "dislikeStamp")
        }

        // update also the blur
        card.swipeFeedbackImage.alpha = 0.5 + (abs(distance) / view.center.x)
    }

    private func changeViewAfterInteraction(_ card: MatchCard, like: Bool) {

        UIView.animate(withDuration: 0.4) {
            guard let cardCenter = self.cardCenter else { return }
            card.center = cardCenter
        }

        if like {
            FirebaseManager.likeUser(currentSummonerId: 2584566, summonerId: 2017255, completion: { _ in
                print("Ok")
            })
        } else {
            // dislike method (?)
        }

        updateCardUser()
    }

    private func resetCardPositionFor(_ card: MatchCard) {

        UIView.animate(withDuration: 0.4) {
            guard let cardCenter = self.cardCenter else { return }
            card.center = cardCenter
            card.swipeFeedbackImage.alpha = 0
        }
    }
}

// MARK: - matchCardDelegate
extension MatchViewController: matchCardDelegate {

    func updateCard() {
        self.updateCardUser()
    }
}
