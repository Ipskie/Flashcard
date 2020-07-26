//
//  Card.swift
//  Flashcard
//
//  Created by Secret Asian Man Dev on 19/7/20.
//

import Foundation
import CoreData



struct FlashCard: Identifiable, Equatable, Hashable {
    var id = UUID()
    var objID: NSManagedObjectID? = nil
    var contents: [Snippet: String?]
    var comfortable: Bool
    
    static let example = FlashCard(
        hiragana: "ひらがな",
        katakana: "カタカナ",
        romaji: "Romaji",
        kanji: "日本語",
        english: "English",
        comfortable: false
    )
    
    init(
        hiragana: String?,
        katakana: String?,
        romaji: String?,
        kanji: String?,
        english: String?,
        comfortable: Bool
    ) {
        contents = [.hiragana: hiragana,
                    .katakana: katakana,
                    .romaji: romaji,
                    .kanji: kanji,
                    .english: english]
        self.comfortable = comfortable
    }
    
    init(from card: Card){
        /// copy the card's object ID so that we can update the object
        objID = card.objectID
        contents = [.hiragana: card.hiragana,
                    .katakana: card.katakana,
                    .romaji: card.romaji,
                    .kanji: card.kanji,
                    .english: card.english]
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
            comfortable: comfortable
        )
    }
    
    /// shorthand for getting text of a particular type
    func snippet(_ type: Snippet) -> String? {
        return contents[type, default: nil]
    }
}
