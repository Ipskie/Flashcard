//
//  Card+CoreDataProperties.swift
//  Flashcard
//
//  Created by Secret Asian Man Dev on 24/7/20.
//
//

import Foundation
import CoreData


extension Card {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Card> {
        return NSFetchRequest<Card>(entityName: "Card")
    }

    @NSManaged public var comfortable: Bool
    @NSManaged public var english: String?
    @NSManaged public var hiragana: String?
    @NSManaged public var id: UUID?
    @NSManaged public var kanji: String?
    @NSManaged public var katakana: String?
    @NSManaged public var romaji: String?
    @NSManaged public var deck: Deck?
    @NSManaged public var history: NSSet?

}

// MARK: Generated accessors for history
extension Card {

    @objc(addHistoryObject:)
    @NSManaged public func addToHistory(_ value: History)

    @objc(removeHistoryObject:)
    @NSManaged public func removeFromHistory(_ value: History)

    @objc(addHistory:)
    @NSManaged public func addToHistory(_ values: NSSet)

    @objc(removeHistory:)
    @NSManaged public func removeFromHistory(_ values: NSSet)

}
