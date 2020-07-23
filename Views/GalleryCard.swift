//
//  GalleryCard.swift
//  Flashcard
//
//  Created by Secret Asian Man Dev on 22/7/20.
//

import SwiftUI

struct GalleryCard: View {
    
    var card: FlashCard
    var promptTypes: [Snippet]
    var answerTypes: [Snippet]
    
    var body: some View {
        VStack(spacing: .zero) {
            ForEach(promptTypes, id: \.self) { prompt in
                Text(card.contents[prompt, default: nil] ?? placeholder)
            }
            Divider()
                .padding([.leading, .trailing])
            ForEach(answerTypes, id: \.self) { answer in
                Text(card.contents[answer, default: nil] ?? placeholder)
            }
            Text("\(card.history.corrects) correct")
            Text("\(card.history.wrongs) wrong")
        }
        .background(CardBG())
        .shadow(radius: 5)
    }
}
