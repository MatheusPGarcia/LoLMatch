//
//  UIViewControllerExtension.swift
//  LoLMatch
//
//  Created by Scarpz on 29/10/18.
//  Copyright © 2018 Matheus Garcia. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func createAlert(title: String?, message: String?, okButton: String = "Ok") {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: okButton, style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
