//
//  APIHelper.swift
//  Zstore
//
//  Created by Saravana Ganesh L on 05/11/23.
//

import Foundation

struct APIHelper: APIHandler {
    func makeRequest(from data: [String: Any]?) -> Request {
        let urlComp = NSURLComponents(string: Constants.baseURL + Constants.path)!
        var urlRequest = URLRequest(url: urlComp.url!)
        
        urlRequest.httpMethod = Constants.get
        let request = Request(urlRequest: urlRequest)
        
        return request
    }
    
    func parseResponse(data: Data) -> Stores? {
        return defaultParseResponse(data: data)
    }
}
