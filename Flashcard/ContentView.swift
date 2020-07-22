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
                .navigationTitle(Text("Decks"))
            }
            
        
//            CardSession(cards: [FlashCard.example])
            Text("Testing Button")
                .onTapGesture {
                    
                    let deck = try! Deck(filename: "Characters.json", context: moc)
                    print(deck)
                    try! moc.save()
//                    var flash = FlashCard.example.copy()
//                    flash.history.append(true)
//                    flash.history.append(false)
//                    flash.history.append(true)
//                    let card = Card(context: moc, flash: flash)
//                    try! moc.save()
//                    print("saved!")
//                    let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: Card.entityName)
//                    let cards = try! moc.fetch(fetch) as! [Card]
//                    print(FlashCard(from: cards.first!))
                }
        }
        
    }
    
}
