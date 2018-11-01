//
//  SignupViewController.swift
//  LoLMatch
//
//  Created by Scarpz on 30/10/18.
//  Copyright © 2018 Matheus Garcia. All rights reserved.
//

import UIKit

class SignupViewController: UITableViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var summonerNameTextField: UITextField!
    @IBOutlet weak var summonerStatusImage: UIImageView!
    @IBOutlet weak var lane1TextField: UITextField!
    @IBOutlet weak var lane2TextField: UITextField!
    @IBOutlet weak var duolane1TextField: UITextField!
    @IBOutlet weak var duolane2TextField: UITextField!
    
    
    // MARK: - Properties
    var summonerStatus: Bool = false
    let availablePrimaryLanes: [Lane] = [.top, .jungle, .mid, .adc, .sup]
    let availableSecondaryLanes: [Lane] = [.top, .jungle, .mid, .adc, .sup, .fill]
    let primaryPicker = UIPickerView()
    let secondaryPicker = UIPickerView()
    

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.lane1TextField.inputView = primaryPicker
        self.duolane1TextField.inputView = primaryPicker
        self.primaryPicker.delegate = self
        
        self.lane2TextField.inputView = secondaryPicker
        self.duolane2TextField.inputView = secondaryPicker
        self.secondaryPicker.delegate = self
        
        self.tableView.keyboardDismissMode = .onDrag
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
    }
    
    
    // MARK: - Actions
    @IBAction func searchSummoner(_ sender: UIButton) {
        
        if let text = self.summonerNameTextField.text {
            if text.isEmpty {
                self.createAlert(title: "Oops...", message: "Preencha o campo de nome de invocador")
            } else {
                self.summonerStatus = true
                self.summonerStatusImage.isHidden = false
                
                self.summonerStatusImage.image = self.summonerStatus ? #imageLiteral(resourceName: "Ok") : #imageLiteral(resourceName: "Nok")
            }
        } else {
            self.createAlert(title: "Oops...", message: "Occoreu um erro. Tente novamente.")
        }
    }
    
    @IBAction func signup(_ sender: UIButton) {
        
        if summonerStatus && !lane1TextField.text!.isEmpty && !lane2TextField.text!.isEmpty && !duolane1TextField.text!.isEmpty && !duolane2TextField.text!.isEmpty {
            
        } else {
            self.createAlert(title: "Oops", message: "Por favor, preencha todos os campos")
        }
    }
}

extension SignupViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerView == primaryPicker ? availablePrimaryLanes.count : availableSecondaryLanes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerView == primaryPicker ? availablePrimaryLanes[row].description() : availableSecondaryLanes[row ].description()
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == self.primaryPicker {
            if lane1TextField.isFirstResponder {
                self.lane1TextField.text = self.availablePrimaryLanes[row].description()
            } else {
                self.duolane1TextField.text = self.availablePrimaryLanes[row].description()
            }
        } else {
            if lane2TextField.isFirstResponder {
                self.lane2TextField.text = self.availableSecondaryLanes[row].description()
            } else {
                self.duolane2TextField.text = self.availableSecondaryLanes[row].description()
            }
        }
    }
   
}
