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
                    
                }
        }
        
    }
    
}
