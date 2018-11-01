//
//  Regions.swift
//  LoLMatch
//
//  Created by Matheus Garcia on 01/11/18.
//  Copyright © 2018 Matheus Garcia. All rights reserved.
//

import Foundation

enum Regions {
    case BR
    case EUNE
    case EUW
    case JP
    case KR
    case LAN
    case LAS
    case NA
    case OCE
    case TR
    case RU
    case PBE

    func getApiCode() -> String {
        switch self {
        case .BR:
            return "br1"
        case .EUNE:
            return "eun1"
        case .EUW:
            return "euw1"
        case .JP:
            return "jp1"
        case .KR:
            return "kr"
        case .LAN:
            return "la1"
        case .LAS:
            return "la2"
        case .NA:
            return "na1"
        case .OCE:
            return "oc1"
        case .TR:
            return "tr1"
        case .RU:
            return "ru"
        case .PBE:
            return "pbe1"
        }
    }
}
