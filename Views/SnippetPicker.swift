//
//  SnippetPicker.swift
//  Flashcard
//
//  Created by Secret Asian Man Dev on 23/7/20.
//

import SwiftUI
import CoreData

struct SnippetPicker: View {
    
    @Environment(\.managedObjectContext) var moc: NSManagedObjectContext
    
    var deck: Deck
    @Binding var prompt: FlashCard.Snippet
    @Binding var answer: FlashCard.Snippet
    
    var body: some View {
        List {
            Section(header: Text("Shown Prompt")) {
                Picker("Shown Prompt", selection: $prompt) {
                    ForEach(FlashCard.Snippet.allCases, id: \.self) {
                        Text($0.name)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            .onChange(of: prompt, perform: {
                deck.promptType = $0
                try! moc.save()
            })
            Section(header: Text("Hidden Answer")) {
                Picker("Hidden Answer", selection: $answer) {
                    ForEach(FlashCard.Snippet.allCases, id: \.self) {
                        Text($0.name)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            .onChange(of: answer, perform: {
                deck.answerType = $0
                try! moc.save()
            })
        }
        .listStyle(GroupedListStyle())
        .navigationTitle("Card Type")
    }
}
