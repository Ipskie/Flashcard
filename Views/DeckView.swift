//
//  DeckView.swift
//  Flashcard
//
//  Created by Secret Asian Man Dev on 20/7/20.
//

import SwiftUI

struct DeckView: View {
    
    var deck: Deck
    
    @State private var prompt: FlashCard.Snippet
    @State private var answer: FlashCard.Snippet
    
    init(deck: Deck) {
        self.deck = deck
        self._prompt = State(initialValue: deck.promptType)
        self._answer = State(initialValue: deck.answerType)
    }
    
    var body: some View {
        List {
            Section(header: Text("Card Type: ")) {
                NavigationLink(destination: SnippetPicker(deck: deck, prompt: $prompt, answer: $answer)) {
                    HStack {
                        Text(deck.promptType.name)
                        Image(systemName: "arrow.right")
                        Text(deck.answerType.name)
                    }
                }
            }
            Section(header: Text("Practice")) {
                NavigationLink(
                    "10 Pull",
                    destination: CardSession(deck: deck, sessionType: .nPull(10))
                )
                NavigationLink(
                    "Marathon \(deck.cards.count) cards",
                    destination: CardSession(deck: deck, sessionType: .marathon)
                )
            }
            Section(header: Text("Deck Information")) {
                NavigationLink("Cards", destination: CardGallery(deck: deck))
            }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationBarTitle(Text(deck._name))
    }
}

