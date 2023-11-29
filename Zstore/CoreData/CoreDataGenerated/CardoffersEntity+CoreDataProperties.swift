//
//  CardoffersEntity+CoreDataProperties.swift
//  Zstore
//
//  Created by Saravana Ganesh L on 11/11/23.
//
//

import Foundation
import CoreData


extension CardoffersEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CardoffersEntity> {
        return NSFetchRequest<CardoffersEntity>(entityName: "CardoffersEntity")
    }

    @NSManaged public var cardname: String?
    @NSManaged public var imageURL: Data?
    @NSManaged public var maxdiscount: String?
    @NSManaged public var offerDesc: String?
    @NSManaged public var offerid: String?
    @NSManaged public var percentage: Double
    @NSManaged public var isOfferSelected: Bool

}

extension CardoffersEntity : Identifiable {

}
