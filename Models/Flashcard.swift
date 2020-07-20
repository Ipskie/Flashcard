//
//  Card.swift
//  Flashcard
//
//  Created by Secret Asian Man Dev on 19/7/20.
//

import Foundation

fileprivate struct RawCard: Decodable {
    var hiragana: String
    var katakana: String
    var romanji: String
    var kanji: String
    var english: String
    // no history for first time de-serialization
}

struct FlashCard: Identifiable, Equatable, Decodable {
    var id = UUID()
    var hiragana: String
    var katakana: String
    var romanji: String
    var kanji: String
    var english: String
    var history: [Bool]
    
    static let example = FlashCard(
        hiragana: "ひらがな",
        katakana: "カタカナ",
        romanji: "Romanji",
        kanji: "日本語",
        english: "English",
        history: []
    )
    
    init(hiragana: String, katakana: String, romanji: String, kanji: String, english: String, history: [Bool]){
        self.hiragana = hiragana
        self.katakana = katakana
        self.romanji = romanji
        self.kanji = kanji
        self.english = english
        self.history = history
    }
    
    init(from decoder: Decoder) throws {
        let rawCard = try RawCard(from: decoder)
        id = UUID()
        hiragana = rawCard.hiragana
        katakana = rawCard.katakana
        romanji = rawCard.romanji
        kanji = rawCard.kanji
        english = rawCard.english
        history = []
    }
    
    init(from card: Card){
        hiragana = card.hiragana ?? " – "
        katakana = card.katakana ?? " – "
        romanji = card.romanji ?? " – "
        kanji = card.kanji ?? " – "
        english = card.english ?? " – "
        history = card.history
    }
    
    func copy(with zone: NSZone? = nil) -> FlashCard {
            let copy = FlashCard(
                hiragana: hiragana,
                katakana: katakana,
                romanji: romanji,
                kanji: kanji,
                english: english,
                history: []
            )
            return copy
        }
}
