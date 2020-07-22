//
//  DeckView.swift
//  Flashcard
//
//  Created by Secret Asian Man Dev on 20/7/20.
//

import SwiftUI

struct DeckView: View {
    
    var deck: Deck
    
    var body: some View {
        List {
            NavigationLink("10 Pull", destination: CardSession(cards: deck.shuffledCards))
        }
        .listStyle(GroupedListStyle())
        .navigationBarTitle(Text(deck._name))
    }
}

