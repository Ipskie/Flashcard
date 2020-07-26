//
//  Deck+CoreDataProperties.swift
//  Flashcard
//
//  Created by Secret Asian Man Dev on 24/7/20.
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
    
    @NSManaged public var chosenTest: Test
    @NSManaged public var cards: NSSet?
    @NSManaged public var tests: NSSet?

    // MARK: - Accessors & Mutators
    
    var _cards: Set<Card> {
        (cards ?? []) as! Set<Card>
    }
    
    var _name: String {
        name ?? "Unnamed Deck"
    }
    
    var _tests: Set<Test> {
        (tests ?? []) as! Set<Test>
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

// MARK: Generated accessors for tests
extension Deck {

    @objc(addTestsObject:)
    @NSManaged public func addToTests(_ value: Test)

    @objc(removeTestsObject:)
    @NSManaged public func removeFromTests(_ value: Test)

    @objc(addTests:)
    @NSManaged public func addToTests(_ values: NSSet)

    @objc(removeTests:)
    @NSManaged public func removeFromTests(_ values: NSSet)

}
