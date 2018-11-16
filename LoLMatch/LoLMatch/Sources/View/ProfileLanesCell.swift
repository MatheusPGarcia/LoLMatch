//
//  ProfileLanesCell.swift
//  LoLMatch
//
//  Created by Scarpz on 16/11/18.
//  Copyright © 2018 Matheus Garcia. All rights reserved.
//

import UIKit

class ProfileLanesCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet private weak var myLanesImages: TripleImageView!
    @IBOutlet private weak var duoLanesImages: TripleImageView!
    
    
    // MARK: - Properties
    private var myLanesPicker = UIPickerView()
    private var duoLanesPicker = UIPickerView()
    

    // MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    // MARK: - Methods
    func setup(user: User) {
        
        self.myLanesImages.setBackgroundColor(forPrimaryView: .black, forSecondaryView: .black)
        self.duoLanesImages.setBackgroundColor(forPrimaryView: .black, forSecondaryView: .black)
        
        self.myLanesImages.primaryImageView.image = user.lane1.coloredImage()
        self.myLanesImages.secondaryImageView.image = user.lane2.coloredImage()
        self.duoLanesImages.primaryImageView.image = user.duoLane1.coloredImage()
        self.duoLanesImages.secondaryImageView.image = user.duoLane2.coloredImage()
    }

}
