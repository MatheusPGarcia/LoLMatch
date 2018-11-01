//
//  ProfileViewController.swift
//  LoLMatch
//
//  Created by Scarpz on 01/11/18.
//  Copyright © 2018 Matheus Garcia. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    
    // MARK: - Outlets
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var summonerName: UILabel!
    
    @IBOutlet weak var primaryLaneView: UIView!
    @IBOutlet weak var primaryLaneImageView: UIImageView!
    @IBOutlet weak var primaryLane: UILabel!
    @IBOutlet weak var secondaryLaneView: UIView!
    @IBOutlet weak var secondaryLaneImageView: UIImageView!
    @IBOutlet weak var secondaryLane: UILabel!
    
    @IBOutlet weak var duoPrimaryLaneView: UIView!
    @IBOutlet weak var duoPrimaryLaneImageView: UIImageView!
    @IBOutlet weak var duoPrimaryLane: UILabel!
    @IBOutlet weak var duoSecondaryLaneView: UIView!
    @IBOutlet weak var duoSecondaryLaneImageView: UIImageView!
    @IBOutlet weak var duoSecondaryLane: UILabel!
    
    
    // MARK: - Properties
    var currentUser: User?
    let availablePrimaryLanes: [Lane] = [.top, .jungle, .mid, .adc, .sup]
    let availableSecondaryLanes: [Lane] = [.top, .jungle, .mid, .adc, .sup, .fill]
    let primaryPicker = UIPickerView(frame: CGRect(x: 0, y: 0, width: 270, height: 150))
    let secondaryPicker = UIPickerView(frame: CGRect(x: 0, y: 0, width: 270, height: 150))
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupProfileView()
        self.displaySummonerInformation()
    }

    
    // MARK: - Actions
    @IBAction func logout(_ sender: Any) {
        UserServices.setCurrentUser(user: nil)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveLanes(_ sender: Any) {
        
        if var user = self.currentUser {
            if let lane1 = self.getLaneFrom(label: self.primaryLane),
                let lane2 = self.getLaneFrom(label: self.secondaryLane),
                let duoLane1 = self.getLaneFrom(label: self.duoPrimaryLane),
                let duoLane2 = self.getLaneFrom(label: self.duoSecondaryLane) {
                
                if user.lane1 != lane1 || user.lane2 != lane2 ||
                    user.duoLane1 != duoLane1 || user.duoLane2 != duoLane2 {
                    user.lane1 = lane1
                    user.lane2 = lane2
                    user.duoLane1 = duoLane1
                    user.duoLane2 = duoLane2
                    
                    self.currentUser = user
                    UserServices.setCurrentUser(user: user)
                    UserServices.setLanes(user: user)
                } else {
                    self.createAlert(title: "Nenhuma alteração feita", message: "Nenhuma lane foi alterada. Para salvar, modifique alguma lane.")
                }
            } else {
                self.createAlert(title: "Oops...", message: "Erro ao pegar as novas lanes. Por favor, tente novamente.")
            }
        } else {
            self.createAlert(title: "Oops...", message: "Erro ao pegar o usuário. Logue novamente.") { [unowned self] _ in
                UserServices.setCurrentUser(user: nil)
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func changeLanes(_ sender: UIButton) {
        
        let vc = UIViewController()
        vc.preferredContentSize = CGSize(width: 270, height: 150)
        
        
        let alert = UIAlertController(title: "Qual lane você deseja selecionar?", message: "", preferredStyle: .alert)
        
        //Add the picker to the alert controller
        alert.setValue(vc, forKey: "contentViewController")
        
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))

        switch sender.tag {
        case 0, 2:
            // My Primary Lane || Duo Primary Lane
            vc.view.addSubview(self.primaryPicker)
        case 1, 3:
            // My Secondary Lane || Duo Secondary Lane
            vc.view.addSubview(self.secondaryPicker)
        default:
            break
        }
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [unowned self] _ in
            
            var index = -1
            if sender.tag == 0 || sender.tag == 2 {
                index = self.primaryPicker.selectedRow(inComponent: 0)
            } else {
                index = self.secondaryPicker.selectedRow(inComponent: 0)
            }
            
            if sender.tag == 0 {
                self.primaryLane.text = self.availablePrimaryLanes[index].description()
                self.primaryLaneImageView.image = self.availablePrimaryLanes[index].image()
            } else if sender.tag == 1 {
                self.secondaryLane.text = self.availableSecondaryLanes[index].description()
                self.secondaryLaneImageView.image = self.availableSecondaryLanes[index].image()
            } else if sender.tag == 2 {
                self.duoPrimaryLane.text = self.availablePrimaryLanes[index].description()
                self.duoPrimaryLaneImageView.image = self.availablePrimaryLanes[index].image()
            } else {
                self.duoSecondaryLane.text = self.availableSecondaryLanes[index].description()
                self.duoSecondaryLaneImageView.image = self.self.availableSecondaryLanes[index].image()
            }
        }))
        
        self.present(alert, animated: true, completion: nil)
        
    }
}


// MARK: - Private Methods
extension ProfileViewController {
    
    private func setupProfileView() {
        
        self.currentUser = UserServices.getCurrentUser()
        
        self.profileView.layer.cornerRadius = self.profileView.frame.width / 2
        self.primaryLaneView.layer.cornerRadius = self.primaryLaneView.frame.width / 2
        self.secondaryLaneView.layer.cornerRadius = self.secondaryLaneView.frame.width / 2
        self.duoPrimaryLaneView.layer.cornerRadius = self.duoPrimaryLaneView.frame.width / 2
        self.duoSecondaryLaneView.layer.cornerRadius = self.duoSecondaryLaneView.frame.width / 2

        self.primaryPicker.delegate = self
        self.secondaryPicker.delegate = self
    }
    
    private func displaySummonerInformation() {
        
        if let user = self.currentUser {
            
            self.summonerName.text = user.summonerName
            
            self.primaryLaneImageView.image = user.lane1.image()
            self.primaryLane.text = user.lane1.description()
            
            self.secondaryLaneImageView.image = user.lane2.image()
            self.secondaryLane.text = user.lane2.description()
            
            self.duoPrimaryLaneImageView.image = user.duoLane1.image()
            self.duoPrimaryLane.text = user.duoLane1.description()
            
            self.duoSecondaryLaneImageView.image = user.duoLane2.image()
            self.duoSecondaryLane.text = user.duoLane2.description()
            
        } else {
            self.createAlert(title: "Oops...", message: "Erro ao pegar o usuário. Logue novamente.") { [unowned self] _ in
                UserServices.setCurrentUser(user: nil)
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    
    private func getLaneFrom(label: UILabel) -> Lane? {
        
        if let laneText = label.text {
            return Lane(value: laneText)
        } else {
            return nil
        }
    }
    
}


// MARK: - Picker View Methods
extension ProfileViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerView == primaryPicker ? availablePrimaryLanes.count : availableSecondaryLanes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerView == primaryPicker ? availablePrimaryLanes[row].description() : availableSecondaryLanes[row ].description()
    }
    
}

