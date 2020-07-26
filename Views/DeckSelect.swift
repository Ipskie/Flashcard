//
//  DeckSelect.swift
//  Flashcard
//
//  Created by Secret Asian Man Dev on 26/7/20.
//

import SwiftUI

struct DeckSelect: View {
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.importFiles) var importAction
    @State var editMode: EditMode = .inactive
    @FetchRequest(
        entity: Deck.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Deck.name, ascending: true)
        ]
    ) var decks: FetchedResults<Deck>
    
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
                            .padding([.top, .bottom, .leading]) /// increase touch target size
                    }
                    .disabled(editMode == .active) /// prevent janky interaction between add and edit buttons
                )
                /// detect when editing
                .environment(\.editMode, $editMode)
            }
        }
    }
}
