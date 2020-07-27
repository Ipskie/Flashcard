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
    @Environment(\.presentationMode) var presentationMode
    @State var editMode: EditMode = .active
    var test: Test
    var onEdited: () -> Void
    @State var prompts: [Snippet]
    @State var answers: [Snippet]
    
    init(
        test: Test,
        onEdited: @escaping () -> Void
    ) {
        self.test = test
        self.onEdited = onEdited
        _prompts = State(initialValue: test._prompts)
        _answers = State(initialValue: test._answers)
    }
    
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
        .onChange(of: prompts) { _ in onEdited() }
        .onChange(of: answers) { _ in onEdited() }
    }
    
    var DoneButton: some View {
        Button {
            presentationMode.wrappedValue.dismiss()
        } label: {
            Text("Done")
                .bold()
        }
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
