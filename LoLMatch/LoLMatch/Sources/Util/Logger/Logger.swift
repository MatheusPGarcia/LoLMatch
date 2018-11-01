//
//  Logger.swift
//  LoLMatch
//
//  Created by Matheus Garcia on 01/11/18.
//  Copyright © 2018 Matheus Garcia. All rights reserved.
//

import Foundation
import XCGLogger

let logger: XCGLogger = {
    let logger = XCGLogger.default
    #if DEBUG
    logger.setup(level: .debug, showThreadName: true, showLevel: true, showFileNames: true, showLineNumbers: true)
    #else
    logger.setup(level: .severe, showThreadName: false, showLevel: false, showFileNames: false, showLineNumbers: false)
    #endif
    return logger
}()
