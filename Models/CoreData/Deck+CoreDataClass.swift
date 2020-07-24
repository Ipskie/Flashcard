//
//  Deck+CoreDataClass.swift
//  Flashcard
//
//  Created by Secret Asian Man Dev on 19/7/20.
//
//

import Foundation
import CoreData

fileprivate struct RawDeck: Decodable {
    var cards: [FlashCard]
    var name: String
}

@objc(Deck)
public class Deck: NSManagedObject {
    
    static let entityName = "Deck" /// for making entity calls
    
    @objc
    private override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }
    
    /// create a Core Data deck by unpacking it from a bundled JSON file
    init(filename: String, context: NSManagedObjectContext) throws {
        super.init(entity: Deck.entity(), insertInto: context)
        id = UUID()
        let rawDeck = Bundle.main.decode(RawDeck.self, from: "Characters.json")
        name = rawDeck.name
        rawDeck.cards.forEach{
            /// initialize each decoded card with this as the deck
            _ = Card.init(context: context, flash: $0, deck: self)
        }
        
        #warning("should make tests based on decoded types!")
        let test = Test(
            prompts: [Snippet.hiragana],
            answers: [Snippet.romaji],
            context: context
        )
        /// need to save here so that test's ID is permanent, not temporary
        try! context.save()
        self.testID = test.objectID.uriRepresentation()
    }
    
    /// return the types of snippet this deck contains (e.g. it's cards might be only Hiragana & English)
    var snippetTypes: [Snippet] {
        let cards = flashcards /// request computed property only once
        return Snippet.allCases.filter({ type in
            cards.contains(where: {
                $0.contents[type] != nil
            })
        })
        /// ensure a consistent ordering
        .sorted(by: {$0.rawValue < $1.rawValue})
    }
}


