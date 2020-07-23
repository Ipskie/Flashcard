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
    @NSManaged public var tests: Set<Test>
    /// the Object ID of the chosen test
    @NSManaged public var testID: NSManagedObjectID

    /// transient property of flashcards derived from Core Data Cards
    var flashcards: [FlashCard] {
        cards.map{FlashCard(from: $0)}
    }
    /// deck name should ALWAYS be set
    var _name: String {
        name ?? "Unknown Deck"
    }
    
    /// which strings the deck should use to prompt the user
    func getPromptTypes(context: NSManagedObjectContext) -> [Snippet] {
        (context.object(with: testID) as! Test)._prompts
    }
    func setPromptTypes(_ prompts: [Snippet], context: NSManagedObjectContext) -> Void {
        (context.object(with: testID) as! Test)._prompts = prompts
    }
    
    /// which strings the deck should use as the answer
    func getAnswerTypes(context: NSManagedObjectContext) -> [Snippet] {
        (context.object(with: testID) as! Test)._answers
    }
    func setAnswerTypes(_ answers: [Snippet], context: NSManagedObjectContext) -> Void {
        (context.object(with: testID) as! Test)._answers = answers
    }
}

// MARK: - Generated accessors for cards
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
