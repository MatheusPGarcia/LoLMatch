//
//  Lane.swift
//  LoLMatch
//
//  Created by Scarpz on 17/10/18.
//  Copyright © 2018 Matheus Garcia. All rights reserved.
//

import UIKit

enum Lane {
    case top, jungle, mid, adc, sup, fill
    
    init(value: String) {
        switch value {
        case "Top":
            self = .top
        case "Jungle":
            self = .jungle
        case "Mid":
            self = .mid
        case "Bot ADC":
            self = .adc
        case "Bot sup":
            self = .sup
        default:
            self = .fill
        }
    }
    
    func description() -> String {
        switch self {
        case .top:
            return "Top"
        case .jungle:
            return "Jungle"
        case .mid:
            return "Mid"
        case .adc:
            return "ADC"
        case .sup:
            return "Support"
        case .fill:
            return "Preencher"
        }
    }
    
    func image() -> UIImage {
        switch self {
        case .top:
            return #imageLiteral(resourceName: "topLane")
        case .jungle:
            return #imageLiteral(resourceName: "jungleLane")
        case .mid:
            return #imageLiteral(resourceName: "midLane")
        case .adc:
            return #imageLiteral(resourceName: "adcLane")
        case .sup:
            return #imageLiteral(resourceName: "supLane")
        case .fill:
            return #imageLiteral(resourceName: "goldIII")
        }
    }
}
