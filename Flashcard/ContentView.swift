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
    
    var body: some View {
        HStack {
            CardSession(cards: [FlashCard.example])
            Text("Testing Button")
                .onTapGesture {
                    var flash = FlashCard.example.copy()
                    flash.history.append(true)
                    flash.history.append(false)
                    flash.history.append(true)
                    let card = Card(context: moc, flash: flash)
                    try! moc.save()
                    print("saved!")
                    let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: Card.entityName)
                    let cards = try! moc.fetch(fetch) as! [Card]
                    print(FlashCard(from: cards.first!))
                }
        }
        
    }
    
}
