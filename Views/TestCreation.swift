//
//  TestCreation.swift
//  Flashcard
//
//  Created by Secret Asian Man Dev on 26/7/20.
//

import SwiftUI
import CoreData

struct TestCreation: View {
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) var moc: NSManagedObjectContext
    @Binding var chosenTest: Test
    @State var prompts: [Snippet] = defaultPrompt
    @State var answers: [Snippet] = defaultAnswer
    var completion: (Test) -> Void 
    
    var body: some View {
        List {
            EditableList(snippets: $prompts, name: "Prompts")
            EditableList(snippets: $answers, name: "Answers")
            Button {
                completion(Test(moc: moc, prompts: prompts, answers: answers))
                presentationMode.wrappedValue.dismiss()
            } label: {
                Text("Done")
                    .bold()
            }
        }
        .navigationBarItems(trailing: CancelButton)
        .listStyle(InsetGroupedListStyle())
        .navigationTitle("New Test")
    }
    
    var CancelButton: some View {
        Button {
            presentationMode.wrappedValue.dismiss()
        } label: {
            Text("Cancel")
                .foregroundColor(.red)
        }
    }
    
    /// lifted from editing screen
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
