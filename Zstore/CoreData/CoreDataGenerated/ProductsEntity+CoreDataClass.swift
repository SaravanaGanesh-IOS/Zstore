//
//  ProductsEntity+CoreDataClass.swift
//  Zstore
//
//  Created by Saravana Ganesh L on 11/11/23.
//
//

import Foundation
import CoreData


public class ProductsEntity: NSManagedObject {
    static let viewContext = NSManagedObjectContext.viewContext
    
    static func insertInto(product store: Stores) {
        let products = getProducts()
        
        let newProduct = store.products.filter { !products.compactMap { $0.productid }.contains($0.id) }
        
        newProduct.forEach { product in
            let productObject = ProductsEntity(context: .viewContext)
            productObject.productid = product.id
            productObject.cardoffers = product.cardOfferIDS
            productObject.catagoryid = product.categoryID
            productObject.imageurl = product.imageURL.imageData
            productObject.name = product.name
            productObject.price = product.price
            productObject.productdescription = product.description
            productObject.rating = product.rating
            productObject.reviewcount = Int64(product.reviewCount)
            productObject.color = product.colors
            productObject.isFavourite = false
            do {
                try NSManagedObjectContext.viewContext.save()
                print("Records saved")
                NotificationCenter.default.post(Notification(name: .productInsertCompleted))
            } catch let error as NSError {
                print("Could not insert. \(error), \(error.localizedDescription)")
            }
        }
    }
    
    static func getProducts() -> [ProductsEntity] {
        var products: [ProductsEntity] = []
        let fetchRequest = ProductsEntity.fetchRequest()
        do {
            products = try viewContext.fetch(fetchRequest)
            return products
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return products
    }
    
    static func addToFavourite(for productId: String, isAdd: Bool) {
        let fetchRequest = ProductsEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "productid == %@", productId)
        do {
            if let productEntity = try viewContext.fetch(fetchRequest).first {
                productEntity.isFavourite = isAdd
            }
            try viewContext.save()
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
}
