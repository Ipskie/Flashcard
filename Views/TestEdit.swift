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
    @State var localTests: [Test]
    @State var editMode: EditMode = .inactive
    
    var onEdited: (Test) -> Void
    var onDeleted: (Test) -> Void
    
    init(
        tests: Binding<[Test]>,
        onEdited: @escaping (Test) -> Void,
        onDeleted: @escaping (Test) -> Void
    ) {
        _tests = tests
        _localTests = State(initialValue: _tests.wrappedValue)
        self.onEdited = onEdited
        self.onDeleted = onDeleted
    }
    
    func locallyEdited(test: Test) -> Void {
        tests.remove(at: tests.firstIndex(where: {$0.id == test.id})!)
        tests.append(test)
        onEdited(test)
    }
    
    var body: some View {
        List {
            ForEach(localTests, id: \.id) { test in
                NavigationLink(
                    test.text,
                    destination: SnippetPicker(test: test, onEdited: locallyEdited)
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
