//
//  DeckView.swift
//  Flashcard
//
//  Created by Secret Asian Man Dev on 20/7/20.
//

import SwiftUI

struct DeckView: View {
    
    @Environment(\.managedObjectContext) var moc
    @State var deck: Deck
    @State private var chosenTest: Test
    @State private var tests: [Test]
    @State private var prompts: [Snippet]
    @State private var answers: [Snippet]
    
    init(deck: Deck) {
        /// bind everything to State so that any changes are updated
        _deck = State(initialValue: deck)
        _chosenTest = State(initialValue: deck.chosenTest)
        _tests = State(initialValue: deck.testsByComplexity)
        _prompts = State(initialValue: deck.chosenTest._prompts)
        _answers = State(initialValue: deck.chosenTest._answers)
    }
    
    /// things to do after a new test is created
    func onTestCreated(test: Test) -> Void {
        deck.chosenTest = test
        deck.addToTests(test)
        tests = deck.testsByComplexity
        chosenTest = test
        prompts = test._prompts
        answers = test._answers
        try! moc.save()
    }
    
    func onTestEdited(test: Test) -> Void {
        if test.chosenBy == deck {
            chosenTest = test
            prompts = test._prompts
            answers = test._answers
        }
        if let idx = tests.firstIndex(of: test) {
            tests[idx] = test /// update value at index
        }
        try! moc.save()
    }
    
    var body: some View {
        List {
            Section(header: Text("Card Type")) {
                DisclosureGroup(chosenTest.text) {
                    ForEach(tests, id: \.id) {
                        TestView($0)
                    }
                    NavigationLink(destination: TestCreation(chosenTest: $chosenTest, completion: onTestCreated)) {
                        HStack {
                            Image(systemName: "plus")
                                .foregroundColor(.blue)
                            Text("New Test")
                        }
                    }
                    NavigationLink(destination: TestEdit(deck: $deck, tests: $tests, onEdited: onTestEdited)) {
                        HStack {
                            Image(systemName: "pencil")
                                .foregroundColor(.blue)
                            Text("Edit Tests")
                        }
                    }
                }
            }
            Section(header: Text("Practice")) {
                NavigationLink(
                    "10 Pull",
                    destination: CardSession(deck: deck, sessionType: .nPull(10))
                )
                NavigationLink(
                    "Marathon All \(deck._cards.count) Cards",
                    destination: CardSession(deck: deck, sessionType: .marathon)
                )
            }
            Section(header: Text("Deck Information")) {
                NavigationLink("Cards", destination: CardGallery(deck: deck))
            }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationBarTitle(Text(deck._name))
    }
    
    func TestView(_ test: Test) -> some View {
        Button {
            chosenTest = test
            deck.chosenTest = test
            print("chsen")
        } label: {
            HStack {
                Image(systemName: "checkmark")
                    .foregroundColor(test.id == chosenTest.id ? .blue : .clear)
                Text(test.text)
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}

