//
//  ContentView.swift
//  Flashcard
//
//  Created by Secret Asian Man Dev on 19/7/20.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(
        entity: Deck.entity(),
        sortDescriptors: []
    ) var decks: FetchedResults<Deck>
    
    var body: some View {
        VStack {
            NavigationView {
                List(decks, id: \.id) { deck in
                    NavigationLink(
                        deck._name,
                        destination: DeckView(deck: deck)
                            .environment(\.managedObjectContext, moc)
                    )
                }
                .listStyle(InsetGroupedListStyle())
                .navigationTitle(Text("Decks"))
            }
            Text("TEST")
                .onTapGesture {
                    /// create and save a new deck from JSON
                    
                    
                    let deck = Deck(
                        moc: moc,
                        name: "Test Deck",
                        cards: Set<Card>(),
                        tests: Set<Test>([Test(moc: moc)])
                    )
                    let card = Card(moc: moc, contents: [.hiragana: "hir", .romaji: "fake card"], deck: deck)
                    try! moc.save()
                    
                    print(deck._cards.count)
                    
                    /// store and retrieve card histories for specific tests
                    print("test ended")
                }
        }
    }
}
