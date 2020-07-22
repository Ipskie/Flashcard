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
        
        /// default prompt: hiragana
        prompt = Int16(FlashCard.Snippet.hiragana.rawValue)
        /// default answer: romaji
        answer = Int16(FlashCard.Snippet.romaji.rawValue)
    }
    
    /// return the types of snippet this deck contains (e.g. it's cards might be only Hiragana & English)
    var snippetTypes: [FlashCard.Snippet] {
        let cards = flashcards /// request computed property only once
        return FlashCard.Snippet.allCases.filter({ type in
            cards.contains(where: {
                $0.contents[type] != nil
            })
        })
        /// ensure a consistent ordering
        .sorted(by: {$0.rawValue < $1.rawValue})
    }
}


