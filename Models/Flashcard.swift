//
//  Card.swift
//  Flashcard
//
//  Created by Secret Asian Man Dev on 19/7/20.
//

import Foundation
import CoreData
import SwiftUI


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
    
    /// shorthand for getting text of a particular type
    func snippet(_ type: Snippet) -> String? {
        return contents[type, default: nil]
    }
    
    /// return a collection of text views for this snippet
    /// includes appropriate coloring for placeholders
    func texts(for snippets: [Snippet], font: Font? = nil) -> some View {
        func text(_ snippet: Snippet) -> Text {
            if let string = contents[snippet, default: nil] {
                return Text(string)
                    .font(font)
            } else {
                return Text(placeholder)
                    .font(font)
                    .foregroundColor(Color(UIColor.placeholderText))
            }
        }
        return Group {
            ForEach(snippets, id: \.self) { snippet in
                text(snippet)
            }
        }
    }
}
