//
//  FlashcardApp.swift
//  Flashcard
//
//  Created by Secret Asian Man Dev on 19/7/20.
//

import SwiftUI
import CoreData

@main
struct FlashcardApp: App {
    
    var persistentContainer: NSPersistentContainer

    init() {
        ValueTransformer.setValueTransformer(SnippetTransformer(), forName: .snippetTransformerName)
        ValueTransformer.setValueTransformer(HistoryTransformer(), forName: .historyTransformerName)
        
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores { description, error in
            if let error = error { fatalError("\(error)") }
        }
        persistentContainer = container
        container.viewContext.mergePolicy = NSOverwriteMergePolicy
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistentContainer.viewContext)
        }
    }
}
