//
//  GalleryCard.swift
//  Flashcard
//
//  Created by Secret Asian Man Dev on 22/7/20.
//

import SwiftUI

struct GalleryCard: View {
    
    var card: Card
    var flashcard: FlashCard
    var prompts: [Snippet]
    var answers: [Snippet]
    
    init(card: Card, prompts: [Snippet], answers: [Snippet]) {
        self.card = card
        self.flashcard = FlashCard(from: card)
        self.prompts = prompts
        self.answers = answers
    }
    
    var body: some View {
        VStack(spacing: .zero) {
            ForEach(prompts, id: \.self) { prompt in
                Text(flashcard.contents[prompt, default: nil] ?? placeholder)
            }
            Divider()
                .padding([.leading, .trailing])
            ForEach(answers, id: \.self) { answer in
                Text(flashcard.contents[answer, default: nil] ?? placeholder)
            }
            #warning("not yet adapted")
            Text("\(card.corrects) correct")
            Text("\(card.wrongs) wrong")
        }
        .background(CardBG())
        .shadow(radius: 5)
    }
}
