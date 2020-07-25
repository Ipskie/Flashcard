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
    @State private var prompts = [Snippet]()
    @State private var answers = [Snippet]()
    
    /// occasionally this would fail on init in the simulator due to nil store coordinator
    func onAppear() {
        precondition(moc.persistentStoreCoordinator != nil)
        prompts = deck.getTest(moc: moc)?._prompts ?? defaultPrompt
        answers = deck.getTest(moc: moc)?._answers ?? defaultAnswer
    }
    
    var body: some View {
        List {
            Section(header: Text("Card Type: ")) {
                NavigationLink(destination: SnippetPicker(deck: deck)) {
                    Text(prompts.map{$0.name}.joined(separator: " + ")
                         + " ➜ "
                         + answers.map{$0.name}.joined(separator: " + ")
                    )
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
        .onAppear {
            onAppear()
        }
    }
}

