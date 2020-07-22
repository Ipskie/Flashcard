//
//  GalleryCard.swift
//  Flashcard
//
//  Created by Secret Asian Man Dev on 22/7/20.
//

import SwiftUI

struct GalleryCard: View {
    
    var card: FlashCard
    var prompt: FlashCard.Snippet
    var answer: FlashCard.Snippet
    
    var body: some View {
        VStack(spacing: .zero) {
            Text(card.contents[prompt, default: nil] ?? placeholder)
            Divider()
            Text(card.contents[answer, default: nil] ?? placeholder)
        }
        .background(CardBG())
        .shadow(radius: 5)
    }
}
