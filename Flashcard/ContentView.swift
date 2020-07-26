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
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Deck.name, ascending: true)
        ]
    ) var decks: FetchedResults<Deck>
    
    @Environment(\.importFiles) var importAction//TEST
    @Environment(\.exportFiles) var exportAction//TEST
    
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
                .navigationBarItems(trailing: EditButton())
                
            }
            DeckSelect()
        }
    }
    
    func getDocumentsDirectory() -> URL {
        // find all possible documents directories for this user
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)

        // just send back the first one, which ought to be the only one
        return paths[0]
    }
    
    func exportTest() -> Void {
        print(getDocumentsDirectory())
    }
    
    func importTest() -> Void {
        importAction(singleOfType: [.json]) { result in
            switch(result){
            case .success(let url):
                precondition(url.isFileURL, "Received a non file URL!")
                print("Success: \(url)")
                do {
                    _ = url.startAccessingSecurityScopedResource()
                    let s = try String(contentsOf: url)
                    url.stopAccessingSecurityScopedResource()
                } catch {
                    print(error)
                }
            case.failure(let error):
                print("Error \(error)")
            case .none:
                break /// happens when user cancelled, do nothing
            }
        }
    }
    
    func coreDataTest() -> Void {
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
