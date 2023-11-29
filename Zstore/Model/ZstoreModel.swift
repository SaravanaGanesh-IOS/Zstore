//
//  ZstoreModel.swift
//  Zstore
//
//  Created by Saravana Ganesh L on 05/11/23.
//

import Foundation
import CoreData

struct Stores: Decodable {
    let category: [Categories]
    let cardOffers: [CardOffer]
    let products: [Product]
    
    enum CodingKeys: String, CodingKey {
        case category
        case cardOffers = "card_offers"
        case products
    }
}

// MARK: - CardOffer
struct CardOffer: Decodable {
    let id: String
    let percentage: Double
    let cardName, offerDesc, maxDiscount: String
    let imageURL: String
    
    enum CodingKeys: String, CodingKey {
        case id, percentage
        case cardName = "card_name"
        case offerDesc = "offer_desc"
        case maxDiscount = "max_discount"
        case imageURL = "image_url"
    }
}

// MARK: - Category
struct Categories: Decodable {
    let id, name, layout: String
}

// MARK: - Product
struct Product: Decodable {
    let id, name: String
    let rating: Double
    let reviewCount: Int
    let price: Double
    let categoryID: String
    let cardOfferIDS: [String]
    let imageURL: String
    let description: String
    let colors: [String]?
    
    enum CodingKeys: String, CodingKey {
        case id, name, rating
        case reviewCount = "review_count"
        case price
        case categoryID = "category_id"
        case cardOfferIDS = "card_offer_ids"
        case imageURL = "image_url"
        case description, colors
    }
}
