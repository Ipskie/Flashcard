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

    @NSManaged public var prompt: Int16
    @NSManaged public var answer: Int16
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
    
    /// which string the deck should use to prompt the user
    /// defaults to hiragana
    var promptType: FlashCard.contents {
        return FlashCard.contents(rawValue: Int(prompt)) ?? .hiragana
    }
    
    /// which string the deck should use as the answer
    /// defaults to romaji
    var answerType: FlashCard.contents {
        return FlashCard.contents(rawValue: Int(prompt)) ?? .romaji
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
