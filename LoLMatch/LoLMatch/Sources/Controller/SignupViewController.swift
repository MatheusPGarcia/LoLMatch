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
    
    @IBOutlet weak var myLanes: TripleImageView!
    @IBOutlet weak var duoLanes: TripleImageView!
    @IBOutlet weak var myLanesTextField: UITextField!
    @IBOutlet weak var duoLanesTextField: UITextField!
    
    @IBOutlet weak var activity: UIActivityIndicatorView!
    @IBOutlet weak var searchButton: UIButton!
    
    
    // MARK: - Properties
    var summonerStatus: Bool = false
    let firstOptionLanes: [Lane] = [.top, .jungle, .mid, .adc, .sup]
    let secondOptionLanes: [Lane] = [.top, .jungle, .mid, .adc, .sup, .fill]
    let primaryPicker = UIPickerView()
    let secondaryPicker = UIPickerView()
    
    var profileIconId: Int?
    var riotName: String?
    var riotSummoner: Int?
    var riotAccount: Int?
    
    var myLane1: Lane?
    var myLane2: Lane?
    var duoLane1: Lane?
    var duoLane2: Lane?
    

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        
        self.myLanesTextField.inputView = primaryPicker
        self.primaryPicker.delegate = self
        
        self.duoLanesTextField.inputView = secondaryPicker
        self.secondaryPicker.delegate = self
        
        self.tableView.keyboardDismissMode = .onDrag
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
        
        self.myLanes.setBackgroundColor(forPrimaryView: .black, forSecondaryView: .black)
        self.duoLanes.setBackgroundColor(forPrimaryView: .black, forSecondaryView: .black)
        
        let accessoryView = SaveButtonAccessory()
        accessoryView.accessoryDelegate = self
        
        self.myLanesTextField.inputAccessoryView = accessoryView
        self.duoLanesTextField.inputAccessoryView = accessoryView
        
        self.checkLogin()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.profileIconId = nil
        self.riotName = nil
        self.riotSummoner = nil
        self.riotAccount = nil
        
        self.summonerStatusImage.isHidden = true
        
        self.summonerNameTextField.text = nil
    }
      
    
    // MARK: - Private Methods
    private func checkLogin() {
        if UserServices.getCurrentUser() != nil {
            self.performSegue(withIdentifier: "SignupSegue", sender: nil)
        }
    }
    
    
    // MARK: - Actions
    @IBAction func searchSummoner(_ sender: UIButton) {
        
        if let text = self.summonerNameTextField.text {
            if text.isEmpty {
                self.createAlert(title: "Oops...", message: "Preencha o campo de nome de invocador")
            } else {

                self.activity.startAnimating()
                self.searchButton.isEnabled = false
                self.summonerStatusImage.isHidden = true
                
                UserServices.getSummonerId(byName: text) { (user, error) in
                    
                    self.activity.stopAnimating()
                    self.searchButton.isEnabled = true
                    
                    if let error = error {
                        print("Error: \(error)")
                        self.summonerStatus = false
                        self.createAlert(title: "Oops...", message: "Occoreu um erro. Tente novamente.")
                    } else {

                        if let userProfileId = user {
                            self.summonerStatus = true

                            self.profileIconId = userProfileId.profileIconId
                            self.riotSummoner = userProfileId.summonerId
                            self.riotAccount = userProfileId.accountId
                            self.riotName = userProfileId.name
                        } else {
                            self.summonerStatus = false
                            self.createAlert(title: "Oops...", message: "Occoreu um erro. Tente novamente.")
                        }

                    }

                    DispatchQueue.main.async {
                        self.summonerStatusImage.isHidden = false
                        self.summonerStatusImage.image = self.summonerStatus ? #imageLiteral(resourceName: "okIcon") : #imageLiteral(resourceName: "nokIcon")
                    }

                }
            }
        } else {
            self.createAlert(title: "Oops...", message: "Occoreu um erro. Tente novamente.")
        }
    }
    
    @IBAction func signup(_ sender: UIBarButtonItem) {
        
        if summonerStatus, let validLane1 = self.myLane1, let validLane2 = self.myLane2,
            let validDuoLane1 = self.duoLane1, let validDuoLane2 = self.duoLane2 {
            
            if let profileIconId = self.profileIconId, let summonerName = self.riotName, let summonerId = self.riotSummoner, let accountId = self.riotAccount {

                let user = User(profileIconId: profileIconId, summonerName: summonerName, summonerId: summonerId, accountId: accountId, lane1: validLane1, lane2: validLane2, duoLane1: validDuoLane1, duoLane2: validDuoLane2)
                
                UserServices.setCurrentUser(user: user)
                UserServices.setLanes(user: user)
                
                print("\(user.toDict())")
                
                self.performSegue(withIdentifier: "SignupSegue", sender: nil)
                
            } else {
                self.createAlert(title: "Oops", message: "Alguma informação da Riot veio inválida. Tente novamente.")
            }
        } else {
            self.createAlert(title: "Oops", message: "Por favor, preencha todos os campos")
        }
    }
}

extension SignupViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerView == primaryPicker ? firstOptionLanes.count : secondOptionLanes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerView == primaryPicker ? firstOptionLanes[row].description() : secondOptionLanes[row ].description()
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == self.primaryPicker {
            if component == 0 {
                self.myLanes.primaryImageView.image = self.firstOptionLanes[row].coloredImage()
            } else {
                self.myLanes.secondaryImageView.image = self.secondOptionLanes[row].coloredImage()
            }
        } else {
            if component == 0 {
                self.duoLanes.primaryImageView.image = self.firstOptionLanes[row].coloredImage()
            } else {
                self.duoLanes.secondaryImageView.image = self.secondOptionLanes[row].coloredImage()
            }
        }
    }
   
}


extension SignupViewController: SaveButtonAccessoryDelegate {
    
    func accessoryButtonPressed() {
        self.myLanesTextField.resignFirstResponder()
        self.duoLanesTextField.resignFirstResponder()
    }
}
