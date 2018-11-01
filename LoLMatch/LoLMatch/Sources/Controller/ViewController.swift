//
//  ViewController.swift
//  LoLMatch
//
//  Created by Matheus Garcia on 16/10/18.
//  Copyright © 2018 Matheus Garcia. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        BaseServiceProvider.getSummonerId(byName: "Scarpz") { (user, error) in
            print(user!)
        }
    }
}
