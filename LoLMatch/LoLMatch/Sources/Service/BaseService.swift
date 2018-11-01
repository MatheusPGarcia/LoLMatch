//
//  BaseService.swift
//  LoLMatch
//
//  Created by Matheus Garcia on 30/10/18.
//  Copyright © 2018 Matheus Garcia. All rights reserved.
//

import Foundation
import Moya
import Result

class BaseService {

    public static func request<T: Codable, K: TargetType>(provider: MoyaProvider<K>, target: K, type: T.Type, completion: @escaping(_ object: T?, _ error: Error?) -> Void) {

        provider.request(target, completion: { (result) in
            parseResult(result: result, type: type, completion: completion)
        })
    }
}

// MARK: - private methods
extension BaseService {

    private static func parseResult<T: Codable>(result: Result<Response, MoyaError>, type: T.Type, completion: @escaping(_ object: T?, _ error: Error?) -> Void) {

        switch result {
        case let .success(response):

            // verify if diferent from 200

            let decoder = JSONDecoder()
            let object = try? response.map(T.self, using: decoder)
            completion(object, nil)

        case let .failure(error):

            completion(nil, error)
            return
        }
    }
}
