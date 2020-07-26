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
    private var prompts: [Snippet]
    private var answers: [Snippet]
    
    let columns = [GridItem(.adaptive(minimum: 80))]
    
    @State var editMode: EditMode = .inactive
    
    init(deck: Deck) {
        self.deck = deck
        prompts = deck.chosenTest._prompts
        answers = deck.chosenTest._answers
    }
    
    var body: some View {
        ScrollView {
            LazyVGrid (columns: columns, spacing: 20) {
                ForEach(deck._cards.sortedBy(.romaji).enumeratedArray(), id: \.element.id) { idx, card in
                    GalleryCard(
                        card: card,
                        index: idx,
                        prompts: prompts,
                        answers: answers,
                        editMode: $editMode
                    )
                }
            }
            .padding()
        }
        .navigationBarItems(trailing: EditButton())
        .navigationTitle("Cards")
        /// detect when editing
        .environment(\.editMode, $editMode)
    }
}
