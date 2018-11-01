//
//  MatchCard.swift
//  LoLMatch
//
//  Created by Scarpz on 16/10/18.
//  Copyright © 2018 Matheus Garcia. All rights reserved.
//

import UIKit

@IBDesignable class MatchCard: UIView {
    
    @IBOutlet weak var swipeFeedbackImage: UIImageView!

    var view = self

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

extension MatchCard {
    
    // MARK: - XIB functions
    
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
