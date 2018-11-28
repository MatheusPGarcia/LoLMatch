//
//  ProfileViewController.swift
//  LoLMatch
//
//  Created by Scarpz on 01/11/18.
//  Copyright © 2018 Matheus Garcia. All rights reserved.
//

import UIKit
import Nuke

enum LaneType {
    case myPrimaryLane
    case mySecondaryLane
    case duoPrimaryLane
    case duoSecondaryLane
}

class ProfileViewController: UIViewController {

    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // Summoner Info
    @IBOutlet weak var summonerImages: TripleImageView!
    @IBOutlet weak var summonerName: UILabel!
    
    
    // MARK: - Properties
    var currentUser: User!
    var myPrimaryLane: Lane!
    var mySecondaryLane: Lane!
    var duoPrimaryLane: Lane!
    var duoSecondaryLane: Lane!
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupProfileView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.dismissAllKeyboards()
    }

    
    // MARK: - Actions
    @IBAction func logout(_ sender: Any) {
        UserServices.setCurrentUser(user: nil)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveLanes(_ sender: Any) {
        
        if var user = self.currentUser {
            
            if user.lane1 != myPrimaryLane || user.lane2 != mySecondaryLane ||
                user.duoLane1 != duoPrimaryLane || user.duoLane2 != duoSecondaryLane {
                user.lane1 = myPrimaryLane
                user.lane2 = mySecondaryLane
                user.duoLane1 = duoPrimaryLane
                user.duoLane2 = duoSecondaryLane
                
                self.currentUser = user
                UserServices.setCurrentUser(user: user)
                UserServices.setLanes(user: user)
                
                self.dismissAllKeyboards()
                
                self.createAlert(title: "Lanes alteradas!", message: nil)
            } else {
                self.createAlert(title: "Nenhuma alteração feita", message: "Nenhuma lane foi alterada. Para salvar, modifique alguma lane.")
            }
        } else {
            self.createAlert(title: "Oops...", message: "Erro ao pegar o usuário. Logue novamente.") { [unowned self] _ in
                UserServices.setCurrentUser(user: nil)
                self.dismiss(animated: true, completion: nil)
            }
        }
    }

}


// MARK: - Private Methods
extension ProfileViewController {
    
    private func setupProfileView() {
        
        if let validUser = UserServices.getCurrentUser() {
            
            self.currentUser = validUser
            
            self.myPrimaryLane = validUser.lane1
            self.mySecondaryLane = validUser.lane2
            self.duoPrimaryLane = validUser.duoLane1
            self.duoSecondaryLane = validUser.duoLane2
            
            self.tableView.delegate = self
            self.tableView.dataSource = self
            self.tableView.keyboardDismissMode = .onDrag
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
    
    private func dismissAllKeyboards() {
        let cell = tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as! ProfileLanesCell
        cell.dismissAllKeyboards()
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
            cell.setup(user: self.currentUser, delegate: self)
            return cell
            
        } else if indexPath.row == 2 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileLastMatchesCell") as! ProfileLastMatchesCell
            cell.setup(user: self.currentUser)
            return cell
            
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


// MARK: - Update Lane Delegate
extension ProfileViewController: UpdateLaneDelegate {
    
    func set(lane: Lane, for laneType: LaneType) {
        switch laneType {
        case .myPrimaryLane:
            self.myPrimaryLane = lane
        case .mySecondaryLane:
            self.mySecondaryLane = lane
        case .duoPrimaryLane:
            self.duoPrimaryLane = lane
        case .duoSecondaryLane:
            self.duoSecondaryLane = lane
        }
    }
    
    func scrollTableView() {
        self.tableView.scrollToRow(at: IndexPath(row: 1, section: 0), at: .top, animated: true)
    }
}
