//
//  TestEdit.swift
//  Flashcard
//
//  Created by Secret Asian Man Dev on 26/7/20.
//

import SwiftUI

struct TestEdit: View {
    
    @Environment(\.managedObjectContext) var moc
    @Binding var deck: Deck
    @Binding var tests: [Test]
    @State var editMode: EditMode = .inactive
    
    var onEdited: (Test) -> Void
    
    var body: some View {
        List {
            ForEach(tests.sorted(by: {$0.prompts.count < $1.prompts.count}), id: \.id) { test in
                NavigationLink(
                    test.text,
                    destination: SnippetPicker(test: test, onEdited: onEdited)
                )
            }
            .onDelete { offsets in
                offsets.forEach {
                    /// terminate if this is only test left
                    guard tests.count > 1 else { return }
                    
                    let test = tests[$0]
                    tests.remove(at: $0) /// remove from collection
                    if deck.chosenTest == test {
                        deck.chosenTest = tests.first! /// need to adjust chosen test if it is deleted
                    }
                    moc.delete(test)
                    try! moc.save()
                    onEdited(deck.chosenTest) /// ask parent view to update
                    
                    /// turn off edits if only 1 view is left
                    if tests.count == 1 { editMode = .inactive }
                }
            }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationTitle(Text("Edit Tests"))
        .navigationBarItems(
            trailing: EditButton()
                /// disallow deletion if it would leave the deck with no tests
                .disabled(tests.count <= 1)
        )
        /// turn editing on
        .environment(\.editMode, $editMode)
    }
}
