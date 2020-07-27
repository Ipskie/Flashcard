//
//  TestEdit.swift
//  Flashcard
//
//  Created by Secret Asian Man Dev on 26/7/20.
//

import SwiftUI

struct TestEdit: View {
    
    @Environment(\.managedObjectContext) var moc
    @Binding var tests: Set<Test>
    @State var editMode: EditMode = .inactive
    
    var onEdited: () -> Void
    
    var body: some View {
        List {
            ForEach(tests.sorted(by: {$0.prompts.count < $1.prompts.count}), id: \.id) { test in
                NavigationLink(
                    test.text,
                    destination: SnippetPicker(test: test, onEdited: onEdited)
                )
            }
            .onDelete { offsets in
                offsets.forEach { moc.delete(tests.sorted(by: {$0.prompts.count < $1.prompts.count}[$0]) }
            }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationTitle(Text("Edit Tests"))
        .navigationBarItems(
            trailing: EditButton()
        )
        /// turn editing on
        .environment(\.editMode, $editMode)
    }
}
