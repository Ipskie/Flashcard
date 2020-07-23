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
                    )
                    
                }
                .listStyle(InsetGroupedListStyle())
                .navigationTitle(Text("Decks"))
            }
            Text("Testing Button")
                .onTapGesture {
                    let req = NSFetchRequest<NSManagedObject>(entityName: "Test")
                    let result = try! moc.fetch(req) as! [Test]
                    print(result.first?.history)
//                    let deck = try! Deck(filename: "Characters.json", context: moc)
//                    print(deck)
                    let test = try! Test(prompts: [.english, .romaji], answers: [.kanji], context: moc)
                    let id = test.objectID
                    try! moc.save()
                    let _test = moc.object(with: id) as! Test
                    
                    print(_test.prompts)
                }
        }
    }
}
