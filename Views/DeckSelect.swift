//
//  DeckSelect.swift
//  Flashcard
//
//  Created by Secret Asian Man Dev on 26/7/20.
//

import SwiftUI

struct DeckSelect: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(
        entity: Deck.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Deck.name, ascending: true)
        ]
    ) var decks: FetchedResults<Deck>
    
    @Environment(\.importFiles) var importAction
    
    var body: some View {
        VStack {
            NavigationView {
                List {
                    ForEach(decks, id: \.id) { deck in
                        NavigationLink(
                            deck._name,
                            destination: DeckView(deck: deck)
                                .environment(\.managedObjectContext, moc)
                        )
                    }
                    .onDelete { offsets in
                        offsets.forEach { moc.delete(decks[$0]) }
                    }
                }
                .listStyle(InsetGroupedListStyle())
                .navigationTitle(Text("Decks"))
                .navigationBarItems(
                    leading: EditButton(),
                    trailing: Button {
                        loadDeck()
                    } label: {
                        Image(systemName: "plus")
                            .padding()
                    }
                )
            }
        }
    }
}
