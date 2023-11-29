//
//  ProductsEntity+CoreDataProperties.swift
//  Zstore
//
//  Created by Saravana Ganesh L on 11/11/23.
//
//

import Foundation
import CoreData


extension ProductsEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProductsEntity> {
        return NSFetchRequest<ProductsEntity>(entityName: "ProductsEntity")
    }

    @NSManaged public var cardoffers: [String]?
    @NSManaged public var catagoryid: String?
    @NSManaged public var color: [String]?
    @NSManaged public var imageurl: Data?
    @NSManaged public var name: String?
    @NSManaged public var price: Double
    @NSManaged public var productdescription: String?
    @NSManaged public var productid: String?
    @NSManaged public var rating: Double
    @NSManaged public var reviewcount: Int64
    @NSManaged public var isFavourite: Bool

}

extension ProductsEntity : Identifiable {

}
