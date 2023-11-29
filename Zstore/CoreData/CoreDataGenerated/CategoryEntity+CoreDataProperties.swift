//
//  CategoryEntity+CoreDataProperties.swift
//  Zstore
//
//  Created by Saravana Ganesh L on 11/11/23.
//
//

import Foundation
import CoreData


extension CategoryEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CategoryEntity> {
        return NSFetchRequest<CategoryEntity>(entityName: "CategoryEntity")
    }

    @NSManaged public var categoryid: String?
    @NSManaged public var layout: String?
    @NSManaged public var name: String?

}

extension CategoryEntity : Identifiable {

}
