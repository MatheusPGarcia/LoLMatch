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
        case "Top", "Topo":
            self = .top
        case "Jungle", "Selva":
            self = .jungle
        case "Mid", "Meio":
            self = .mid
        case "Bot ADC", "ADC":
            self = .adc
        case "Bot sup", "Suporte":
            self = .sup
        default:
            self = .fill
        }
    }
    
    func description() -> String {
        switch self {
        case .top:
            return "Topo"
        case .jungle:
            return "Selva"
        case .mid:
            return "Meio"
        case .adc:
            return "ADC"
        case .sup:
            return "Suporte"
        case .fill:
            return "Preencher"
        }
    }
    
    func keyDescription() -> String {
        switch self {
        case .top:
            return "Top"
        case .jungle:
            return "Jungle"
        case .mid:
            return "Mid"
        case .adc:
            return "Bot ADC"
        case .sup:
            return "Bot sup"
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
            return #imageLiteral(resourceName: "fillLane")
        }
    }
    
    func coloredImage() -> UIImage {
        switch self {
        case .top:
            return #imageLiteral(resourceName: "coloredTopLane")
        case .jungle:
            return #imageLiteral(resourceName: "coloredJungleLane")
        case .mid:
            return #imageLiteral(resourceName: "coloredMidLane")
        case .adc:
            return #imageLiteral(resourceName: "coloredAdcLane")
        case .sup:
            return #imageLiteral(resourceName: "coloredSupLane")
        case .fill:
            return #imageLiteral(resourceName: "coloredFillLane")
        }
    }
}
