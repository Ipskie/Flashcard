//
//  Card+CoreDataProperties.swift
//  Flashcard
//
//  Created by Secret Asian Man Dev on 19/7/20.
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
    @NSManaged public var history: NSObject?
    @NSManaged public var id: UUID?
    @NSManaged public var katakana: String?
    @NSManaged public var romanji: String?
    @NSManaged public var deck: Deck?

}
