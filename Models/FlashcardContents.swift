//
//  FlashcardContents.swift
//  Flashcard
//
//  Created by Secret Asian Man Dev on 22/7/20.
//

import Foundation

extension FlashCard {
    
    /// types of content that might be displayed on the flashcard
    enum contents: Int {
        case hiragana
        case romaji
        case kanji
        case katakana
        case english
        
        /// return the name of the content type
        func name() -> String {
            switch self {
            case .hiragana: return "Hiragana"
            case .romaji: return "Romaji"
            case .kanji: return "Kanji"
            case .english: return "English"
            case .katakana: return "Katakana"
            }
        }
    }
    

}
