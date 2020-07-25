//
//  DeckView.swift
//  Flashcard
//
//  Created by Secret Asian Man Dev on 20/7/20.
//

import SwiftUI

struct DeckView: View {
    
    var deck: Deck
    @Environment(\.managedObjectContext) var moc
    @State private var promptTypes = [Snippet]()
    @State private var answerTypes = [Snippet]()
    
    init(deck: Deck) {
        self.deck = deck
        self._promptTypes = State(initialValue: deck.getTest(moc: moc)._prompts)
        self._answerTypes = State(initialValue: deck.getTest(moc: moc)._answers)
    }
    
    var body: some View {
        List {
            Section(header: Text("Card Type: ")) {
                NavigationLink(destination: SnippetPicker(deck: deck, promptTypes: $promptTypes, answerTypes: $answerTypes)) {
                    HStack {
                        ForEach(promptTypes, id: \.self) { type in
                            Text(type.name)
                        }
                        Image(systemName: "arrow.right")
                        ForEach(answerTypes, id: \.self) { type in
                            Text(type.name)
                        }
                    }
                }
            }
            Section(header: Text("Practice")) {
                NavigationLink(
                    "10 Pull",
                    destination: CardSession(deck: deck, sessionType: .nPull(10))
                )
                NavigationLink(
                    "Marathon \(deck._cards.count) cards",
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

