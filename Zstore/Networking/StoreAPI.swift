//
//  StoreAPI.swift
//  Zstore
//
//  Created by Saravana Ganesh L on 05/11/23.
//

import Foundation

final class StoresAPI {
    static let shared = StoresAPI()
    private init() {}
    
    func getStores(with completionHandler: @escaping(_ result: Result<Stores, ResponseError>) -> Void) {
        let apiRequest = APIHelper()
        let apiTaskLoader = APILoader(apiRequest)
        
        apiTaskLoader.loadRequest(requestData: nil) { result in
            completionHandler(result)
        }
    }
}
