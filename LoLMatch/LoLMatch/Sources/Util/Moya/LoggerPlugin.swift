//
//  LoggerPlugin.swift
//  LoLMatch
//
//  Created by Matheus Garcia on 01/11/18.
//  Copyright © 2018 Matheus Garcia. All rights reserved.
//

import Foundation
import Moya
import Result

final class LoggerPlugin: PluginType {

    private var logData: Bool = true

    func process(_ result: Result<Response, MoyaError>, target: TargetType) -> Result<Response, MoyaError> {

        logger.debug("""
            \n\n ===============================================
            \n URL: \(target.method.rawValue.uppercased()) - \(target.baseURL)/\(target.path)
            \n Headers: \(target.headers?.description ?? "")
            \n Task: \(target.task)
            """)

        switch result {
        case let .success(response):
            do {
                let data = try response.mapJSON()
                if logData {
                    logger.debug("\n\n Result Data: \(data)\n")
                }
            } catch {
                let printableError = error as CustomStringConvertible
                logger.debug("\n\n Error: \(printableError)\n")
            }
        case let .failure(error):
            logger.debug("\n\n Error: \(error)\n")
        }
        return result
    }
}
