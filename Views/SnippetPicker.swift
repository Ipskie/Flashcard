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
    @State var editMode: EditMode = .inactive
    var deck: Deck
    @State var prompts = [Snippet]()
    @State var answers = [Snippet]()
    
    init(deck: Deck) {
        self.deck = deck
        
    }
    
    /// store coordinator isn't present on init
    func onAppear() {
        precondition(moc.persistentStoreCoordinator != nil)
        prompts = deck.getTest(moc: moc)!._prompts
        answers = deck.getTest(moc: moc)!._answers
    }
    
    var body: some View {
        List {
            EditableList(snippets: $prompts)
        }
        .onAppear{ onAppear() }
        .navigationBarItems(trailing: EditButton())
        .listStyle(InsetGroupedListStyle())
        .navigationTitle("Card Type")
        .environment(\.editMode, self.$editMode)
    }
    
    func EditableList(snippets: Binding<[Snippet]>) -> some View {
        Group {
            Section(header: Text("Card Prompts")) {
                ForEach(snippets.wrappedValue, id: \.self) { snippet in
                    Text(snippet.name)
                }
                .onMove { source, destination in
                    snippets.wrappedValue.move(fromOffsets: source, toOffset: destination)
                }
                .onDelete { offsets in
                    snippets.wrappedValue.remove(atOffsets: offsets)
                }
            }
            if editMode == .active {
                Section (header: Text("Add Prompts")) {
                    ForEach(Snippet.allCases.filter{!snippets.wrappedValue.contains($0)}, id: \.self) { snippet in
                        Button {
                            withAnimation {
                                snippets.wrappedValue.append(snippet)
                            }
                        } label: {
                            HStack {
                                Image(systemName: "plus.circle.fill")
                                    .foregroundColor(.green)
                                Text(snippet.name)
                            }
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
            }

        }
    }
}
