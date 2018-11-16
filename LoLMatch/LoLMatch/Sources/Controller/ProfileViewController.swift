//
//  ProfileViewController.swift
//  LoLMatch
//
//  Created by Scarpz on 01/11/18.
//  Copyright © 2018 Matheus Garcia. All rights reserved.
//

import UIKit
import Nuke

class ProfileViewController: UIViewController {

    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // Summoner Info
    @IBOutlet weak var summonerImages: TripleImageView!
    @IBOutlet weak var summonerName: UILabel!
    
    
    // MARK: - Properties
    var currentUser: User!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupProfileView()
        self.displaySummonerInformation()
    }

    
    // MARK: - Actions
    @IBAction func logout(_ sender: Any) {
        UserServices.setCurrentUser(user: nil)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveLanes(_ sender: Any) {
        
    }

}


// MARK: - Private Methods
extension ProfileViewController {
    
    private func setupProfileView() {
        
        if let validUser = UserServices.getCurrentUser() {
            
            self.currentUser = validUser
            
            self.tableView.delegate = self
            self.tableView.dataSource = self
            self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
            self.navigationController?.navigationBar.shadowImage = UIImage()
            self.navigationController?.navigationBar.isTranslucent = true
            self.navigationController?.view.backgroundColor = .clear
        } else {
            self.createAlert(title: "Oops...", message: "Erro ao pegar o Invocador atual") { [unowned self] _ in
                self.dismiss(animated: true, completion: nil)
            }
        }
        
    }
    
    private func displaySummonerInformation() {
        
        
    }
    
}


// MARK: - TableView Methods
extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileInfoCell") as! ProfileInfoCell
            cell.setup(user: self.currentUser, delegate: self)
            return cell
            
        } else if indexPath.row == 1 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileLanesCell") as! ProfileLanesCell
            cell.setup(user: self.currentUser)
            return cell
            
        } else if indexPath.row == 2 {
            return UITableViewCell()
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}


// MARK: - Cell Delegate
extension ProfileViewController: CellDelegate {
    
    func displayAlert(title: String, message: String) {
        self.createAlert(title: title, message: message)
    }
}
