//
//  ParseManager.swift
//  LoLMatch
//
//  Created by Matheus Garcia on 16/10/18.
//  Copyright © 2018 Matheus Garcia. All rights reserved.
//

import Foundation
import Result
import Moya

class ParseManager {

    static func parseData<T: Codable>(result: Result<Response, MoyaError>, type: T.Type, completion: @escaping(_ object: T?, _ error: Error?) -> Void) {

        switch result {
        case let .success(response):

            let decoder = JSONDecoder()
            let object = try? response.map(T.self, using: decoder)
            completion(object, nil)
            return

        case let .failure(error):
            completion(nil, error)
            return
        }
    }
}
