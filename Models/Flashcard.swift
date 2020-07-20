//
//  Card.swift
//  Flashcard
//
//  Created by Secret Asian Man Dev on 19/7/20.
//

import Foundation

fileprivate struct RawCard: Decodable {
    var prompt: String
    var answer: String
}

struct FlashCard: Identifiable, Equatable, Decodable {
    var id = UUID()
    var prompt: String
    var answer: String
    
    static let example = FlashCard (prompt: "Prompt", answer: "Answer")
    
    init(prompt: String, answer: String) {
        id = UUID()
        self.prompt = prompt
        self.answer = answer
    }
    
    init(from decoder: Decoder) throws {
        let rawCard = try RawCard(from: decoder)
        id = UUID()
        prompt = rawCard.prompt
        answer = rawCard.answer
    }
}
