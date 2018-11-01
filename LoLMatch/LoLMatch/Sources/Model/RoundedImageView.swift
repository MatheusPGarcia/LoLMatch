//
//  RoundedImageView.swift
//  LoLMatch
//
//  Created by Scarpz on 16/10/18.
//  Copyright © 2018 Matheus Garcia. All rights reserved.
//

import UIKit

class RoundedImageView: UIImageView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.cornerRadius = max(self.frame.height, self.frame.width) / 2
    }
}
