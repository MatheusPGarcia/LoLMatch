//
//  LikesReceivedViewController.swift
//  LoLMatch
//
//  Created by Scarpz on 17/10/18.
//  Copyright © 2018 Matheus Garcia. All rights reserved.
//

import UIKit

class LikesReceivedViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    
    
    // MARK: - Properties
    var users = [User]()
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupViewLikesReceived()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loadUsers()
    }

}


// MARK: - Private Methods
extension LikesReceivedViewController {
    
    private func setupViewLikesReceived() {
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    private func loadUsers() {
        
        self.users.removeAll()
        
        UserServices.getAllUsers { [unowned self] users in
            
            if let validUsers = users {
                self.users = validUsers
                self.loadReceivedLikes()
            }
        }
    }
    
    private func loadReceivedLikes() {

        UserServices.getAllReceivedLikes() { [unowned self] receivedLikes in
            
            var usersLiked = [User]()
            
            if let validLikes = receivedLikes {
                
                for validLike in validLikes {
                    for user in self.users where user.summonerId == validLike {
                        usersLiked.append(user)
                    }
                }
            }
            
            self.users = usersLiked
            
            self.tableView.reloadData()
        }
    }
    
    private func likeUser(summonerId: Int) {
        UserServices.matchUser(summonerId: summonerId) { success in
            if success {
                // TODO: Go to the Match View (?)
                self.createAlert(title: "Match Efetuado", message: "Nicely done, Invocador")
                
                self.loadReceivedLikes()
            } else {
                self.createAlert(title: "Oops...", message: "Houve algum problema. Tente novamente.")
            }
        }
    }
    
    private func dislikeUser(summonerId: Int) {
        print("Implement")
    }
    
}


// MARK: - Table View Methods
extension LikesReceivedViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LikesReceivedCell") as! LikesReceivedCell
        cell.setup(user: self.users[indexPath.row], delegate: self)
        cell.layoutSubviews()
        cell.layoutIfNeeded()
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 194
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let likeAction = UIContextualAction(style: .normal, title: "Like") { [unowned self] (action, view, completion) in
            self.likeUser(summonerId: self.users[indexPath.row].summonerId)
        }
        likeAction.image = #imageLiteral(resourceName: "Ok")
        likeAction.backgroundColor = .green
        return UISwipeActionsConfiguration(actions: [likeAction])
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let dislikeAction = UIContextualAction(style: .normal, title: "Dislike") { [unowned self] (action, view, completion) in
            print("Implement")
        }
        dislikeAction.image = #imageLiteral(resourceName: "Nok")
        dislikeAction.backgroundColor = .red
        return UISwipeActionsConfiguration(actions: [dislikeAction])
    }
    
}


// MARK: - Like User Delegate
extension LikesReceivedViewController: LikeUserDelegate {

    
    
    func displayAlert(title: String, message: String) {
        self.createAlert(title: title, message: message)
    }
}
