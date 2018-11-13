//
//  ScarpzRequest.swift
//  LoLMatch
//
//  Created by Scarpz on 13/11/18.
//  Copyright © 2018 Matheus Garcia. All rights reserved.
//

import Foundation

class ScarpzRequest {
    
    static func request(url: String, body: Data?, headers: [String : String]?, completion: @escaping (_ response: [String : Any]?, _ error: Error?) -> Void) {
        
        guard let validURL = URL(string: url) else {
            print("Error on URL")
            return
        }
        
        var request = URLRequest(url: validURL)
        request.httpMethod = "GET"
        request.httpBody = body
        request.allHTTPHeaderFields = headers
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if error == nil {
                
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: []) as! [String : Any]
                    
                    completion(json, nil)
                } catch {
                    completion(nil, nil)
                }
                
            } else {
                completion(nil, error)
            }
        }
        task.resume()
    }
    
    
}
