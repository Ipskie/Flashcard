//
//  CardGallery.swift
//  Flashcard
//
//  Created by Secret Asian Man Dev on 22/7/20.
//

import SwiftUI

struct CardGallery: View {
    
    var deck: Deck
    
    @Environment(\.managedObjectContext) var moc
    private var promptTypes = [Snippet]()
    private var answerTypes = [Snippet]()
    
    let columns = [GridItem(.adaptive(minimum: 80))]
    
    init(deck: Deck) {
        self.deck = deck
//        promptTypes = deck.getPromptTypes(context: moc)
//        answerTypes = deck.getAnswerTypes(context: moc)
    }
    
    var body: some View {
        ScrollView {
            LazyVGrid (columns: columns, spacing: 20) {
//                ForEach(deck.cards.sortedBy(.romaji), id: \.id) { card in
//                    GalleryCard(
//                        card: FlashCard(from: card),
//                        promptTypes: promptTypes,
//                        answerTypes: answerTypes
//                    )
//                }
            }
            .padding()
        }
        .navigationTitle("Cards")
    }
}
