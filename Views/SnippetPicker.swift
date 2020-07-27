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
    @Binding var test: Test
    var onEdited: (Test) -> Void
    @State var prompts: [Snippet]
    @State var answers: [Snippet]
    
    init(
        test: Binding<Test>,
        onEdited: @escaping (Test) -> Void
    ) {
        _test = test
        self.onEdited = onEdited
        _prompts = State(initialValue: test.wrappedValue._prompts)
        _answers = State(initialValue: test.wrappedValue._answers)
    }
    
    var body: some View {
        List {
            EditableList(snippets: $prompts, name: "Prompts")
            EditableList(snippets: $answers, name: "Answers")
        }
        .listStyle(InsetGroupedListStyle())
        .navigationTitle("Card Type")
        /// detect when editing
        .environment(\.editMode, $editMode)
        .onChange(of: prompts) {
            test._prompts = $0
            onEdited(test)
        }
        .onChange(of: answers) {
            test._answers = $0
            onEdited(test)
        }
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
