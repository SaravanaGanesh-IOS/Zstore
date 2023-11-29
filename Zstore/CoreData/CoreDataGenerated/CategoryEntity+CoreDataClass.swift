//
//  CategoryEntity+CoreDataClass.swift
//  Zstore
//
//  Created by Saravana Ganesh L on 11/11/23.
//
//

import Foundation
import CoreData


public class CategoryEntity: NSManagedObject {
    static let viewContext = NSManagedObjectContext.viewContext

    static func insertCategory(from store: Stores) {
        let categories = getCategories()
        
        let newCategories = store.category.filter { !categories.compactMap { $0.categoryid }.contains($0.id) }
        
        newCategories.forEach { catagory in
            
            let categoriesEntity = CategoryEntity(context: .viewContext)
            categoriesEntity.categoryid = catagory.id
            categoriesEntity.name = catagory.name
            categoriesEntity.layout = catagory.layout
        }
        
        do {
            try NSManagedObjectContext.viewContext.save()
            NotificationCenter.default.post(Notification(name: .categoryInsertCompleted))
            CardoffersEntity.insertCardOffer(from: store)
        } catch let error as NSError {
            print("Could not insert. \(error), \(error.localizedDescription)")
        }
    }
    
    static func getCategories() -> [CategoryEntity] {
        var categories: [CategoryEntity] = []
        let fetchRequest = CategoryEntity.fetchRequest()
        let sortDesciptor = NSSortDescriptor(key: "categoryid", ascending: true)
        fetchRequest.sortDescriptors = [sortDesciptor]
        do {
            categories = try viewContext.fetch(fetchRequest)
            return categories
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return categories
    }
}
