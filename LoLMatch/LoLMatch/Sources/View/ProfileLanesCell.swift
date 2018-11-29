//
//  ProfileLanesCell.swift
//  LoLMatch
//
//  Created by Scarpz on 16/11/18.
//  Copyright © 2018 Matheus Garcia. All rights reserved.
//

import UIKit

protocol UpdateLaneDelegate: class {
    func set(lane: Lane, for laneType: LaneType)
    func scrollTableView()
    func saveLane()
}

class ProfileLanesCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet private weak var myLanesImages: TripleImageView!
    @IBOutlet private weak var duoLanesImages: TripleImageView!
    @IBOutlet weak var myLanesTextField: UITextField!
    @IBOutlet weak var duoLanesTextField: UITextField!
    
    
    // MARK: - Properties
    private var myLanesPicker = UIPickerView()
    private let firstOptionLanes: [Lane] = [.top, .jungle, .mid, .adc, .sup]
    private var duoLanesPicker = UIPickerView()
    private let secondOptionLanes: [Lane] = [.top, .jungle, .mid, .adc, .sup, .fill]
    
    weak var delegate: UpdateLaneDelegate?

    // MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    // MARK: - Actions
    @IBAction func activeTextField(_ sender: UITextField) {
        self.delegate?.scrollTableView()
    }
    
    
    
    // MARK: - Methods
    func setup(user: User, delegate: UpdateLaneDelegate) {
        
        self.delegate = delegate
        
        self.myLanesImages.setBackgroundColor(forPrimaryView: .black, forSecondaryView: .black)
        self.duoLanesImages.setBackgroundColor(forPrimaryView: .black, forSecondaryView: .black)
        
        self.myLanesImages.primaryImageView.image = user.lane1.coloredImage()
        self.myLanesImages.secondaryImageView.image = user.lane2.coloredImage()
        self.duoLanesImages.primaryImageView.image = user.duoLane1.coloredImage()
        self.duoLanesImages.secondaryImageView.image = user.duoLane2.coloredImage()
        
        self.myLanesTextField.inputView = myLanesPicker
        self.duoLanesTextField.inputView = duoLanesPicker
        
        self.myLanesPicker.delegate = self
        self.myLanesPicker.dataSource = self
        
        self.duoLanesPicker.delegate = self
        self.duoLanesPicker.dataSource = self
        
        let accessoryView = SaveButtonAccessory()
        accessoryView.accessoryDelegate = self
        
        self.myLanesTextField.inputAccessoryView = accessoryView
        self.duoLanesTextField.inputAccessoryView = accessoryView
        
    }
    
    func dismissAllKeyboards() {
        self.myLanesTextField.resignFirstResponder()
        self.duoLanesTextField.resignFirstResponder()
    }
}


// MARK: - Picker View Methods
extension ProfileLanesCell: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return component == 0 ? self.firstOptionLanes.count : self.secondOptionLanes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return component == 0 ? self.firstOptionLanes[row].description() : self.secondOptionLanes[row].description()
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == self.myLanesPicker {
            if component == 0 {
                self.myLanesImages.primaryImageView.image = self.firstOptionLanes[row].coloredImage()
                self.delegate?.set(lane: self.firstOptionLanes[row], for: .myPrimaryLane)
            } else {
                self.myLanesImages.secondaryImageView.image = self.secondOptionLanes[row].coloredImage()
                self.delegate?.set(lane: self.secondOptionLanes[row], for: .mySecondaryLane)
            }
        } else {
            if component == 0 {
                self.duoLanesImages.primaryImageView.image = self.firstOptionLanes[row].coloredImage()
                self.delegate?.set(lane: self.firstOptionLanes[row], for: .duoPrimaryLane)
            } else {
                self.duoLanesImages.secondaryImageView.image = self.secondOptionLanes[row].coloredImage()
                self.delegate?.set(lane: self.secondOptionLanes[row], for: .duoSecondaryLane)
            }
        }
    }
    
}


extension ProfileLanesCell: SaveButtonAccessoryDelegate {
    func accessoryButtonPressed() {
        delegate?.saveLane()
    }
}
