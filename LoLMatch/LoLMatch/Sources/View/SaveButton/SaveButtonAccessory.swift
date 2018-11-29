//
//  SaveButton.swift
//  LoLMatch
//
//  Created by Scarpz on 29/11/18.
//  Copyright © 2018 Matheus Garcia. All rights reserved.
//

import UIKit

protocol SaveButtonAccessoryDelegate: class {
    func accessoryButtonPressed()
}

class SaveButtonAccessory: UIToolbar {
    
    weak var accessoryDelegate: SaveButtonAccessoryDelegate?
    
    init() {
        super.init(frame: .zero)
        barStyle = UIBarStyle.default
        isTranslucent = true
        sizeToFit()
        isUserInteractionEnabled = true
        barTintColor = .navyBlue
        
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let button = UIBarButtonItem(title: "SALVAR", style: .done, target: self, action: #selector(buttonTapped(_:)))
        button.tintColor = .gold
        
        setItems([spaceButton, button], animated: true)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @objc func buttonTapped(_ sender: UIBarButtonItem) {
        accessoryDelegate?.accessoryButtonPressed()
    }
    
}

