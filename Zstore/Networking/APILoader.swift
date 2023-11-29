//
//  APILoader.swift
//  Zstore
//
//  Created by Saravana Ganesh L on 05/11/23.
//

import Foundation

struct APILoader<T: APIHandler> {
    let apiRequest: T
    let urlSession: URLSession
    
    init(_ apiRequest: T, _ urlSession: URLSession = .shared) {
        self.apiRequest = apiRequest
        self.urlSession = urlSession
    }
    
    func loadRequest(requestData: T.RequestDataType, completionHandler: @escaping(_ result: Result<T.ResponseDataType, ResponseError>) -> Void) {
        let urlRequest = apiRequest.makeRequest(from: requestData).urlRequest
        
        urlSession.dataTask(with: urlRequest) { data, response, error in
            if true {
                guard error == nil else {
                    completionHandler(.failure(.clientError))
                    return
                }
                
                guard let response = (response as? HTTPURLResponse), 200...299 ~= response.statusCode  else {
                    completionHandler(.failure(.serverError))
                    return
                }
                
                guard let data = data else {
                    completionHandler(.failure(.noData))
                    return
                }
                
                if let decodedData = self.apiRequest.parseResponse(data: data) {
                    completionHandler(.success(decodedData))
                    return
                } else {
                    completionHandler(.failure(.dataDecodingError))
                    return
                }
            } else {
                completionHandler(.failure(.noInternet))
            }
        }.resume()
    }
}
