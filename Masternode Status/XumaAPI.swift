//
//  XumaAPI.swift
//  Masternode Status
//
//  Created by Dillon on 4/20/18.
//  Copyright © 2018 Dillon Petito. All rights reserved.
//

import Foundation

struct Xuma: CustomStringConvertible {
    var temp: String
    var address: String
    
    var description: String {
        return "\(temp)"
    }
}


class XumaAPI {

    
    func xumaFromJSONData(_ data: Data, _ query: String) -> Xuma? {
        
        let xuma = Xuma(
            temp: String(data: data, encoding: .utf8)!,
            address: query
        )
        
        return xuma
    }
    
    
    
    let BASE_URL = "http://explorer.xumacoin.org/ext/getbalance/"
    
    func fetchXuma(_ query: String, success: @escaping (Xuma) -> Void) {
        let session = URLSession.shared
        // url-escape the query string we're passed
        let escapedQuery = query.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        let url = URL(string: "\(BASE_URL)\(escapedQuery!)")
        let task = session.dataTask(with: url!) { data, response, err in
            // first check for a hard error
            if let error = err {
                NSLog("api error: \(error)")
            }
            
            // then check the response code
            if let httpResponse = response as? HTTPURLResponse {
                switch httpResponse.statusCode {
                case 200: // all good!
                    if let xuma = self.xumaFromJSONData(data!, escapedQuery!) {
                        success(xuma)
                    }
                case 401: // unauthorized
                    NSLog("unauthorized")
                default:
                    NSLog("returned response: %d %@", httpResponse.statusCode, HTTPURLResponse.localizedString(forStatusCode: httpResponse.statusCode))
                }
            }
        }
        task.resume()
    }
}
