//
//  CardGallery.swift
//  Flashcard
//
//  Created by Secret Asian Man Dev on 22/7/20.
//

import SwiftUI

struct CardGallery: View {
    
    var deck: Deck
    
    let columns = [GridItem(.adaptive(minimum: 80))]
    
    var body: some View {
        ScrollView {
            LazyVGrid (columns: columns, spacing: 20) {
                ForEach(deck.cards.sortedBy(.romaji), id: \.id) { card in
                    Text(card.romaji ?? " – ")
                }
            }
        }
    }
}
