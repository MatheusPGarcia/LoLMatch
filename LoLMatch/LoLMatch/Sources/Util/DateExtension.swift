//
//  DateExtension.swift
//  LoLMatch
//
//  Created by Scarpz on 29/10/18.
//  Copyright © 2018 Matheus Garcia. All rights reserved.
//

import Foundation

extension Date {
    
    func parseToString(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
}
