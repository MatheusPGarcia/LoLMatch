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
    @IBOutlet weak var centerYConstraint: NSLayoutConstraint!
    @IBOutlet weak var centerXConstraint: NSLayoutConstraint!

    private var currentUserElo: String?
    private var actionDistance: CGFloat?

    private var cards =  [User]()

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.getFeed()
        
        ChampionService.getChampionList { champions, error in
            if let _ = champions {
                
                guard let currentUserId = UserServices.getCurrentUser()?.summonerId else { return }
                UserServices.getElo(byId: currentUserId) { [weak self] (eloArray, error) in
                    guard let self = self else { return }
                    
                    guard let elo = eloArray?.first(where: { $0.queueType == "RANKED_SOLO_5x5" }) else { return }
                    self.currentUserElo = elo.tier
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true

        actionDistance = view.frame.width / 2
        self.setupMatchView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }

    @IBAction func matchCardPressed(_ sender: UIPanGestureRecognizer) {

        guard let cardReference = sender.view as? MatchCard else { return }

        let point = sender.translation(in: view)

        let xPoint = point.x
        let yPoint = point.y

        centerXConstraint.constant = xPoint
        centerYConstraint.constant = yPoint
        
        self.view.layoutIfNeeded()

        updateFeedbackImage(distance: xPoint)

        if sender.state == UIGestureRecognizer.State.ended {

            guard let actionDistance = self.actionDistance else { return }

            if xPoint > actionDistance {
                changeViewAfterInteraction(cardReference, like: true)
            } else if xPoint < (-1 * actionDistance) {
                changeViewAfterInteraction(cardReference, like: false)
            } else {
                resetCardPosition()
            }
        }
    }
}

// MARK: - private methods
extension MatchViewController {
    
    private func setupMatchView() {
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

        print("Getting new user")
        guard let user = cards.first, let currentUserElo = currentUserElo else {  return }
        cardView.setupView(summoner: user, currentUserTier: currentUserElo, delegate: self)
        cards.removeFirst()
    }

    private func filterFeed(_ currentUsers: [User]) {

        let selfUser = UserServices.getCurrentUser()
        let filteredUsers = currentUsers.filter { $0.summonerId != selfUser?.summonerId }
        self.cards = filteredUsers
    }

    private func updateFeedbackImage(distance: CGFloat) {

        if distance > 0 {
            cardView.swipeFeedbackImage.image = UIImage(named: "likeStamp")
        } else {
            cardView.swipeFeedbackImage.image = UIImage(named: "dislikeStamp")
        }

        // update also the blur
        cardView.swipeFeedbackImage.alpha = 0.5 + (abs(distance) / view.center.x) / 2
    }

    private func changeViewAfterInteraction(_ card: MatchCard, like: Bool) {

        resetCardPosition()

        if like {
            FirebaseManager.likeUser(currentSummonerId: 2584566, summonerId: 2017255, completion: { _ in
                print("Ok")
            })
        } else {
            // dislike method (?)
        }

        updateCardUser()
    }

    private func resetCardPosition() {

        centerXConstraint.constant = 0
        centerYConstraint.constant = 0

        UIView.animate(withDuration: 0.4) {
            self.view.layoutIfNeeded()
            self.cardView.swipeFeedbackImage.alpha = 0
        }
    }
}

// MARK: - matchCardDelegate
extension MatchViewController: matchCardDelegate {

    func updateCard() {
        self.updateCardUser()
    }
}
