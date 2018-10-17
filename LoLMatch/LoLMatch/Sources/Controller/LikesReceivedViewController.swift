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
        
        UserServices.getAllUsers { users in
            if let validUsers = users {
                self.users = validUsers
                self.tableView.reloadData()
            }
        }
    }
    
}


// MARK: - Table View Methods
extension LikesReceivedViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LikesReceivedCell") as! LikesReceivedCell
        cell.setup(user: self.users[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 388
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 388
    }
    
}
