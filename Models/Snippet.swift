//
//  FlashcardContents.swift
//  Flashcard
//
//  Created by Secret Asian Man Dev on 22/7/20.
//

import Foundation

/// snippets of content that could be displayed on a flashcard
enum Snippet: Int, CaseIterable {
    /// NOTE: Order of appearance below should match ordering in menus etc.
    case hiragana = 0
    case romaji
    case kanji
    case katakana
    case english
    
    /// return the name of the snippet type
    var name: String {
        switch self {
        case .hiragana: return "Hiragana"
        case .romaji: return "Romaji"
        case .kanji: return "Kanji"
        case .english: return "English"
        case .katakana: return "Katakana"
        }
    }
}

