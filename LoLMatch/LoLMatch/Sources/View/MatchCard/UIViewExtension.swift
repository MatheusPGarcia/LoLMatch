//
//  UIViewExtension.swift
//  LoLMatch
//
//  Created by Scarpz on 16/10/18.
//  Copyright © 2018 Matheus Garcia. All rights reserved.
//

import UIKit

extension UIView {
    
    /// Inspectable property to set the corner radius in the Storyboard
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
//            layer.masksToBounds = newValue > 0
        }
    }
    
    /// Inspectable property to set the border width in the Storyboard
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    /// Inspectable property to set the border color in the Storyboard
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
}
