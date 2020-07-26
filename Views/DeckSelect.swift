//
//  DeckSelect.swift
//  Flashcard
//
//  Created by Secret Asian Man Dev on 26/7/20.
//

import SwiftUI
import CoreData

struct DeckSelect: View {
    
    @Environment(\.importFiles) var importAction
    @Environment(\.managedObjectContext) var moc: NSManagedObjectContext
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .onTapGesture {
                loadDeck()
            }
    }
    
    
}
