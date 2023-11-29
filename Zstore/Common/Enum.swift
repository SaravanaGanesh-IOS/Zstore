//
//  Enum.swift
//  Zstore
//
//  Created by Saravana Ganesh L on 05/11/23.
//

import Foundation

enum ResponseError: Error {
    case clientError
    case serverError
    case noData
    case dataDecodingError
    case noInternet
}

enum StoreSection: Int, CaseIterable {
    case catagories = 0, cardoffer, product
}

enum CardOfferBank: String {
    case hdfc = "11236"
    case ifbc = "10132"
    case axis = "10134"
}

enum Sorting: String, CaseIterable {
    case Rating = "rating"
    case Price = "price"
    
    var description: String {
        switch self {
        case .Rating:
            return "Rating"
        case .Price:
            return "Price"
        }
    }
}

enum Layout: String, CaseIterable {
    case waterfall = "waterfall"
    case composite = "linear"
}
