//
//  DoubleImageView.swift
//  LoLMatch
//
//  Created by Scarpz on 17/10/18.
//  Copyright © 2018 Matheus Garcia. All rights reserved.
//

import UIKit

@IBDesignable class DoubleImageView: UIView {
    
    // MARK: - Outlets
    @IBOutlet weak var primaryView: UIView!
    @IBOutlet weak var primaryImageView: UIImageView!
    @IBOutlet weak var secondaryView: UIView!
    @IBOutlet weak var secondaryImageView: UIImageView!

 
    // MARK: - Properties
    // Content view of the XIB
    private var contentView: UIView?
    
    
    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupXib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupXib()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.setupXib()
    }
}


// MARK: - XIB functions
extension DoubleImageView {

    /// Instantiate the view defined in a xib file using the same name of the class
    ///
    /// - Returns: the first view found in the xib or nil if it was unable to find any view
    func loadViewFromXib() -> UIView? {
        
        let bundle = Bundle(for: type(of: self))
        
        // load the xib from the main bundle
        let xib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        
        // load the view inside the xib
        return xib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
    /// Loads the xib, associates it to the contentView and add it to the view's hierarchy
    func setupXib() {
        // only load the xib if the contentView is not loaded yet
        if self.contentView == nil {
            // load content view from xib
            
            // if it has failed, this example needs to be rewriten
            guard let contentView = loadViewFromXib() else {
                fatalError("Can't load the view from \(String(describing: type(of: self))).xib")
            }
            
            // adjust the contentView to have the same size of the view itself
            contentView.frame = bounds
            
            // let the content view adjusts automatically for flexible size (width and height)
            contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            
            // add content view to the view hierarchy
            self.addSubview(contentView)
            
            self.contentView = contentView
        }
    }
}


// MARK: - Visual setup on Storyboard
extension DoubleImageView {
    
    /// Inspectable property to set the corner radius state of Primary View in the Storyboard
    @IBInspectable var isPrimaryViewRounded: Bool {
        get {
            return false
        }
        set {
            self.layoutIfNeeded()
            self.layoutSubviews()
            self.primaryView.layer.cornerRadius = newValue ? self.primaryView.frame.width / 2 : 0
            self.primaryView.layer.masksToBounds = true
        }
    }
    
    /// Inspectable property to set the corner radius state of Secondary View in the Storyboard
    @IBInspectable var isSecondaryViewRounded: Bool {
        get {
            return false
        }
        set {
            self.layoutIfNeeded()
            self.layoutSubviews()
            self.secondaryView.layer.cornerRadius = newValue ? self.secondaryView.frame.width / 2 : 0
            self.secondaryView.layer.masksToBounds = true
        }
    }
    
    /// Inspectable property to set the border width of the Primary View in the Storyboard
    @IBInspectable var primaryBorderWidth: CGFloat {
        get {
            return self.primaryView.layer.borderWidth
        }
        set {
            self.primaryView.layer.borderWidth = newValue
        }
    }
    
    /// Inspectable property to set the border width of the Secondary View in the Storyboard
    @IBInspectable var secondaryBorderWidth: CGFloat {
        get {
            return self.secondaryView.layer.borderWidth
        }
        set {
            self.secondaryView.layer.borderWidth = newValue
        }
    }
    
    /// Inspectable property to set the border color in the Storyboard
    @IBInspectable var primaryBorderColor: UIColor? {
        get {
            return UIColor(cgColor: self.primaryView.layer.borderColor!)
        }
        set {
            self.primaryView.layer.borderColor = newValue?.cgColor
        }
    }
    
    /// Inspectable property to set the border color in the Storyboard
    @IBInspectable var secondaryBorderColor: UIColor? {
        get {
            return UIColor(cgColor: self.secondaryView.layer.borderColor!)
        }
        set {
            self.secondaryView.layer.borderColor = newValue?.cgColor
        }
    }
    
    /// Inspectable property to set the Primary Image in the Storyboard
    @IBInspectable var primaryImage: UIImage? {
        get {
            return self.primaryImageView.image
        }
        set {
            self.primaryImageView.image = newValue
        }
    }
    
    /// Inspectable property to set the Secondary Image in the Storyboard
    @IBInspectable var secondaryImage: UIImage? {
        get {
            return self.secondaryImageView.image
        }
        set {
            self.secondaryImageView.image = newValue
        }
    }
}

