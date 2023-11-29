//
//  APIHandler.swift
//  Zstore
//
//  Created by Saravana Ganesh L on 05/11/23.
//

import Foundation

//MARK: - REQUEST & RESPONSE HANDLER
protocol RequestHandler {
    associatedtype RequestDataType
    
    func makeRequest(from data: RequestDataType) -> Request
}

protocol ResponseHandler {
    associatedtype ResponseDataType
    
    func parseResponse(data: Data) -> ResponseDataType?
}

typealias APIHandler = RequestHandler & ResponseHandler

//MARK: - REQUEST
class Request {
    private let request: URLRequest
    
    init(urlRequest: URLRequest) {
        request = urlRequest
    }
    
    var urlRequest: URLRequest {
        return request
    }
}

//MARK: - RESPONSE HANDLER
extension ResponseHandler {
    ///Generic response data handler
    func defaultParseResponse<T: Decodable>(data: Data) -> T? {
        
        return T.decodedData(data)
    }
}
