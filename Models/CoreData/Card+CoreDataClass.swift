//
//  Card+CoreDataClass.swift
//  Flashcard
//
//  Created by Secret Asian Man Dev on 24/7/20.
//
//

import Foundation
import CoreData

fileprivate struct RawCard: Decodable {
    var hiragana: String?
    var katakana: String?
    var romaji: String?
    var kanji: String?
    var english: String?
    // no history for first time de-serialization
}

@objc(Card)
public class Card: NSManagedObject, Codable {
    
    static let entityName = "Card" /// for making entity calls
    
    @objc
    private override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }

    init(
        moc: NSManagedObjectContext,
        contents: [Snippet: String],
        deck: Deck
    ) {
        super.init(entity: Card.entity(), insertInto: moc)
        self.deck = deck
        id = UUID()
        
        /// initialize with un-comfortable and no history
        history = []
        comfortable = false
        
        english = contents[.english]
        romaji = contents[.romaji]
        kanji = contents[.kanji]
        hiragana = contents[.hiragana]
        katakana = contents[.katakana]
    }
    
    init(from flash: FlashCard, moc: NSManagedObjectContext) {
        super.init(entity: Card.entity(), insertInto: moc)
        id = UUID()
        
        /// initialize with un-comfortable and no history
        history = []
        comfortable = false
        
        english = flash.contents[.english] ?? nil
        romaji = flash.contents[.romaji] ?? nil
        kanji = flash.contents[.kanji] ?? nil
        hiragana = flash.contents[.hiragana] ?? nil
        katakana = flash.contents[.katakana] ?? nil
    }
    
    public required init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[.context] as? NSManagedObjectContext else { fatalError("NSManagedObjectContext is missing") }
        super.init(entity: Card.entity(), insertInto: context)
        
    }
    
    init(from decoder: Decoder) throws {
        let rawCard = try RawCard(from: decoder)
        id = UUID()
        contents = [.hiragana: rawCard.hiragana,
                    .katakana: rawCard.katakana,
                    .romaji: rawCard.romaji,
                    .kanji: rawCard.kanji,
                    .english: rawCard.english]
        comfortable = false /// when decoding new deck, default to not comfortable
    }
}
