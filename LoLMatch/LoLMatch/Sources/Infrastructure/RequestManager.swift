//
//  RequestManager.swift
//  LoLMatch
//
//  Created by Scarpz on 01/11/18.
//  Copyright © 2018 Matheus Garcia. All rights reserved.
//

import Foundation

class RequestManager {
    
    static func request(userName: String, completion: @escaping (_ response: [String : Any]?, _ error: Error?) -> Void) {
        
        let summonerName = userName.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        
        let url = "https://br1.api.riotgames.com/lol/summoner/v3/summoners/by-name/\(summonerName)"
        
        guard let validURL = URL(string: url) else {
            print("Error on URL")
            return
        }
        
        var request = URLRequest(url: validURL)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = ["X-Riot-Token" : "RGAPI-8bc32542-f82f-45fb-99b7-120679888066"]
        
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
