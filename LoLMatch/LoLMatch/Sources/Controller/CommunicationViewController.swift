//
//  CommunicationViewController.swift
//  LoLMatch
//
//  Created by Scarpz on 07/11/18.
//  Copyright © 2018 Matheus Garcia. All rights reserved.
//

import UIKit

class CommunicationViewController: UIViewController {

    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    
    // MARK: - Properties
    var matchUsers = [User]()
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupCommunicationView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loadUsers()
    }
    
    
    // MARK: - Actions
    @IBAction func showInformation(_ sender: Any) {
        self.createAlert(title: "Adicione seu match ingame para jogar com ele", message: nil)
    }
}


// MARK: - Private Methods
extension CommunicationViewController {
    
    private func setupCommunicationView() {
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
    }
    
    private func loadUsers() {
        
        self.matchUsers.removeAll()
        
        UserServices.getAllUsers { [unowned self] users in
            
            if let validUsers = users {
                self.matchUsers = validUsers
                self.loadMatches()
            }
        }
    }
    
    private func loadMatches() {
        
        UserServices.getAllMatches() { [unowned self] receivedLikes in
            
            var usersMatched = [User]()
            
            if let validLikes = receivedLikes {
                
                for validLike in validLikes {
                    for user in self.matchUsers where user.summonerId == validLike {
                        usersMatched.append(user)
                    }
                }
            }
            
            self.matchUsers = usersMatched
            
            self.tableView.reloadData()
        }
    }
}


// MARK: - TableView Methods
extension CommunicationViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.matchUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MatchCell") as! MatchCell
        cell.setup(user: self.matchUsers[indexPath.row])
        return cell
    }
    
}
