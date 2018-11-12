//
//  CustomNavigationController.swift
//  LoLMatch
//
//  Created by Scarpz on 12/11/18.
//  Copyright © 2018 Matheus Garcia. All rights reserved.
//

import UIKit

class CustomNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationBar.prefersLargeTitles = false
        self.navigationBar.barTintColor = UIColor(red: 10, green: 20, blue: 30, alpha: 1)
        
        self.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor(red: 243, green: 165, blue: 54, alpha: 1),
            NSAttributedString.Key.font: UIFont(name: "Libel Suit", size: 25)!
        ]
    }

}
