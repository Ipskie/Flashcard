//
//  Card.swift
//  Flashcard
//
//  Created by Secret Asian Man Dev on 19/7/20.
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

struct FlashCard: Identifiable, Equatable, Decodable, Hashable {
    var id = UUID()
    var objID: NSManagedObjectID? = nil
    var contents: [Snippet: String?]
    var history: [Bool]
    var comfortable: Bool
    
    static let example = FlashCard(
        hiragana: "ひらがな",
        katakana: "カタカナ",
        romaji: "Romaji",
        kanji: "日本語",
        english: "English",
        history: [],
        comfortable: false
    )
    
    init(
        hiragana: String?,
        katakana: String?,
        romaji: String?,
        kanji: String?,
        english: String?,
        history: [Bool],
        comfortable: Bool
    ) {
        contents = [.hiragana: hiragana,
                    .katakana: katakana,
                    .romaji: romaji,
                    .kanji: kanji,
                    .english: english]
        self.history = history
        self.comfortable = comfortable
    }
    
    init(from decoder: Decoder) throws {
        let rawCard = try RawCard(from: decoder)
        id = UUID()
        contents = [.hiragana: rawCard.hiragana,
                    .katakana: rawCard.katakana,
                    .romaji: rawCard.romaji,
                    .kanji: rawCard.kanji,
                    .english: rawCard.english]
        history = []
        comfortable = false /// when decoding new deck, default to not comfortable
    }
    
    init(from card: Card){
        /// copy the card's object ID so that we can update the object
        objID = card.objectID
        contents = [.hiragana: card.hiragana,
                    .katakana: card.katakana,
                    .romaji: card.romaji,
                    .kanji: card.kanji,
                    .english: card.english]
        history = [Bool](from: card.history ?? "")
        comfortable = card.comfortable
    }
    
    /** clone contents onto a new FlashCard
        this tricks swiftUI into not persisting a CardView after we shuffle
        a card back into the deck
     */
    func copy(with zone: NSZone? = nil) -> FlashCard {
        return FlashCard(
            hiragana: contents[.hiragana, default: nil],
            katakana: contents[.katakana, default: nil],
            romaji: contents[.romaji, default: nil],
            kanji: contents[.kanji, default: nil],
            english: contents[.english, default: nil],
            history: [],
            comfortable: comfortable
        )
    }
    
    /// shorthand for getting text of a particular type
    func snippet(_ type: Snippet) -> String? {
        return contents[type, default: nil]
    }
}
