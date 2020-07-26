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
    @Binding var prompts: [Snippet]
    @Binding var answers: [Snippet]
    
    var body: some View {
        List {
            EditableList(snippets: $prompts, name: "Prompts")
            EditableList(snippets: $answers, name: "Answers")
        }
        .navigationBarItems(trailing: EditButton())
        .listStyle(InsetGroupedListStyle())
        .navigationTitle("Card Type")
        /// detect when editing
        .environment(\.editMode, $editMode)
    }
    
    func EditableList(snippets: Binding<[Snippet]>, name: String) -> some View {
        Group {
            Section(header: Text("Card \(name)")) {
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
                Section (header: Text("Add \(name)")) {
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
