//
//  ContentView.swift
//  Flashcard
//
//  Created by Secret Asian Man Dev on 19/7/20.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var moc: NSManagedObjectContext
//    @FetchRequest(
//        entity: Deck.entity(),
//        sortDescriptors: []
//    ) var decks: FetchedResults<Deck>
    var body: some View {
        VStack {
            TestView()
//            NavigationView {
//                List(decks, id: \.id) { deck in
//                    NavigationLink(
//                        deck._name,
//                        destination: DeckView(deck: deck)
//                    )
//
//                }
//                .listStyle(InsetGroupedListStyle())
//                .navigationTitle(Text("Decks"))
//            }
//            Text("Testing Button")
//                .onTapGesture {
//                    let deck = try! Deck(filename: "Characters.json", context: moc)
//                    print(deck)
//                    try! moc.save()
//                }
        }
    }
}

/// for testing my data layer
struct TestView: View {
    var body: some View {
        Text("TEST")
            .onTapGesture {
                /// create and save a new deck from JSON
                
                /// store and retrieve card histories for specific tests
            }
    }
}
