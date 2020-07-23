//
//  GalleryCard.swift
//  Flashcard
//
//  Created by Secret Asian Man Dev on 22/7/20.
//

import SwiftUI

struct GalleryCard: View {
    
    var card: FlashCard
    var prompt: Snippet
    var answer: Snippet
    
    var body: some View {
        VStack(spacing: .zero) {
            Text(card.contents[prompt, default: nil] ?? placeholder)
            Divider()
                .padding([.leading, .trailing])
            Text(card.contents[answer, default: nil] ?? placeholder)
            Text("\(card.history.corrects) correct")
            Text("\(card.history.wrongs) wrong")
        }
        .background(CardBG())
        .shadow(radius: 5)
    }
}
