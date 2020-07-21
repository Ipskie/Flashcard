//
//  Deck+CoreDataProperties.swift
//  Flashcard
//
//  Created by Secret Asian Man Dev on 19/7/20.
//
//

import Foundation
import CoreData


extension Deck {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Deck> {
        return NSFetchRequest<Deck>(entityName: "Deck")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var cards: Set<Card>

    /// deck name should ALWAYS be set
    var _name: String {
        name ?? "Unknown Deck"
    }
    var shuffledCards: [FlashCard] {
        cards.map{FlashCard(from: $0)}.shuffled()
    }
}

// MARK: Generated accessors for cards
extension Deck {

    @objc(addCardsObject:)
    @NSManaged public func addToCards(_ value: Card)

    @objc(removeCardsObject:)
    @NSManaged public func removeFromCards(_ value: Card)

    @objc(addCards:)
    @NSManaged public func addToCards(_ values: NSSet)

    @objc(removeCards:)
    @NSManaged public func removeFromCards(_ values: NSSet)

}
