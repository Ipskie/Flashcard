//
//  TestEdit.swift
//  Flashcard
//
//  Created by Secret Asian Man Dev on 26/7/20.
//

import SwiftUI

struct TestEdit: View {
    
    @Environment(\.managedObjectContext) var moc
    @Binding var tests: [Test]
    @State var editMode: EditMode = .inactive
    
    var onEdited: (Test) -> Void
    var onDeleted: (Test) -> Void
    
    var body: some View {
        List {
            ForEach(tests.enumeratedArray(), id: \.element.id) { idx, test in
                NavigationLink(
                    test.text,
                    destination: SnippetPicker(test: $tests[idx], onEdited: onEdited)
                )
            }
            .onDelete { offsets in
                offsets.forEach {
                    onDeleted(tests[$0]) /// also handles deletion from the bound list
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
