//
//  Card.swift
//  Flashcard
//
//  Created by Secret Asian Man Dev on 19/7/20.
//

import Foundation

fileprivate struct RawCard: Decodable {
    var hiragana: String?
    var katakana: String?
    var romaji: String?
    var kanji: String?
    var english: String?
    // no history for first time de-serialization
}

struct FlashCard: Identifiable, Equatable, Decodable {
    var id = UUID()
    var hiragana: String?
    var katakana: String?
    var romaji: String?
    var kanji: String?
    var english: String?
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
    
    /// types of content that might be displayed on the flashcard
    enum contents: Int {
        case hiragana
        case romaji
        case kanji
        case katakana
        case english
    }
    
    init(
        hiragana: String?,
        katakana: String?,
        romaji: String?,
        kanji: String?,
        english: String?,
        history: [Bool],
        comfortable: Bool
    ) {
        self.hiragana = hiragana
        self.katakana = katakana
        self.romaji = romaji
        self.kanji = kanji
        self.english = english
        self.history = history
        self.comfortable = comfortable
    }
    
    init(from decoder: Decoder) throws {
        let rawCard = try RawCard(from: decoder)
        id = UUID()
        hiragana = rawCard.hiragana
        katakana = rawCard.katakana
        romaji = rawCard.romaji
        kanji = rawCard.kanji
        english = rawCard.english
        history = []
        comfortable = false /// when decoding new deck, default to not comfortable
    }
    
    init(from card: Card){
        hiragana = card.hiragana ?? " – "
        katakana = card.katakana ?? " – "
        romaji = card.romaji ?? " – "
        kanji = card.kanji ?? " – "
        english = card.english ?? " – "
        history = [Bool](from: card.history ?? "")
        comfortable = card.comfortable
    }
    
    func copy(with zone: NSZone? = nil) -> FlashCard {
            let copy = FlashCard(
                hiragana: hiragana,
                katakana: katakana,
                romaji: romaji,
                kanji: kanji,
                english: english,
                history: [],
                comfortable: comfortable
            )
            return copy
        }
}
