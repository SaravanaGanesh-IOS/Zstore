//
//  CardoffersEntity+CoreDataClass.swift
//  Zstore
//
//  Created by Saravana Ganesh L on 11/11/23.
//
//

import Foundation
import CoreData


public class CardoffersEntity: NSManagedObject {
    static let viewContext = NSManagedObjectContext.viewContext

    static func insertCardOffer(from store: Stores) {
        let cardOffer = getCardOffers()
        
        let newOffers = store.cardOffers.filter { !cardOffer.compactMap { $0.offerid }.contains($0.id) }
        
        newOffers.forEach { cardOffer in
            let cardOfferEntity = CardoffersEntity(context: .viewContext)
            cardOfferEntity.offerid = cardOffer.id
            cardOfferEntity.cardname = cardOffer.cardName
            cardOfferEntity.imageURL = cardOffer.imageURL.imageData
            cardOfferEntity.maxdiscount = cardOffer.maxDiscount
            cardOfferEntity.offerDesc = cardOffer.offerDesc
            cardOfferEntity.percentage = cardOffer.percentage
            cardOfferEntity.isOfferSelected = false
        }
        
        do {
            try viewContext.save()
            NotificationCenter.default.post(Notification.init(name: .cardOfferInsertCompleted))
            ProductsEntity.insertInto(product: store)
        } catch let error as NSError {
            print("Could not insert. \(error), \(error.localizedDescription)")
        }
    }
    
    static func getCardOffers() -> [CardoffersEntity] {
        var cardOffers: [CardoffersEntity] = []
        let fetchRequest = CardoffersEntity.fetchRequest()
        do {
            cardOffers = try viewContext.fetch(fetchRequest)
            return cardOffers
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return cardOffers
    }
    
    static func updateOfferSelection(for selectedOfferId: String) {
        let fetchRequest = CardoffersEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "offerid == %@", selectedOfferId)
        do {
            if let cardOffer = try viewContext.fetch(fetchRequest).first {
                cardOffer.isOfferSelected = true
            }
            try viewContext.save()
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    static func resetOfferSelection() {
        var cardOffers: [CardoffersEntity] = []
        let fetchRequest = CardoffersEntity.fetchRequest()
        do {
            cardOffers = try viewContext.fetch(fetchRequest)
            cardOffers.forEach { cardOffer in
                cardOffer.isOfferSelected = false
            }
            try viewContext.save()
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    static func getSelectedOffer() -> CardoffersEntity? {
        let fetchRequest = CardoffersEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "isOfferSelected == true")
        fetchRequest.fetchLimit = 1
        do {
            guard let cardOffer = try viewContext.fetch(fetchRequest).first else { return nil }
            return cardOffer
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return nil
    }
}
