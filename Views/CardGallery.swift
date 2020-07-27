//
//  CardGallery.swift
//  Flashcard
//
//  Created by Secret Asian Man Dev on 22/7/20.
//

import SwiftUI

struct CardGallery: View {
    
    @Binding var cards: [Card]
    
    @Environment(\.managedObjectContext) var moc
    var prompts: [Snippet]
    var answers: [Snippet]
    
    let columns = [GridItem(.adaptive(minimum: 80))]
    
    @State var editMode: EditMode = .inactive
    
    var onDelete: (Card) -> Void
    
    var body: some View {
        ScrollView {
            LazyVGrid (columns: columns, spacing: 20) {
                ForEach(cards.enumeratedArray(), id: \.element.id) { idx, card in
                    GalleryCard(
                        card: card,
                        index: idx,
                        prompts: prompts,
                        answers: answers,
                        editMode: $editMode,
                        removal: delete
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
    
    func delete(_ card: Card) -> Void {
        cards.remove(at: cards.firstIndex(of: card)!)
        onDelete(card)
    }
}
