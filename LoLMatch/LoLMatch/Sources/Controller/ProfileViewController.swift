//
//  ProfileViewController.swift
//  LoLMatch
//
//  Created by Scarpz on 01/11/18.
//  Copyright © 2018 Matheus Garcia. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    
    // MARK: - Outlets
    
    
    // MARK: - Properties
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    // MARK: - Actions
    @IBAction func logout(_ sender: Any) {
        UserServices.setCurrentUser(user: nil)
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
