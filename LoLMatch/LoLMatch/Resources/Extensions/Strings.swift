//
//  Strings.swift
//  LoLMatch
//
//  Created by Matheus Garcia on 22/11/18.
//  Copyright © 2018 Matheus Garcia. All rights reserved.
//

import Foundation

extension String {

    static var tierText: String { return NSLocalizedString("%@", comment: "text uset to show the player rank")}

    static var pdlText: String { return NSLocalizedString("%d PDL | %dW %dL", comment: "text used in cards pdl")}

    static var kdaText: String { return NSLocalizedString("%d/%d/%d", comment: "text used in kda")}
}
