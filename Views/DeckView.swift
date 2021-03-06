//
//  DeckView.swift
//  Flashcard
//
//  Created by Secret Asian Man Dev on 20/7/20.
//

import SwiftUI

struct DeckView: View {
    
    @Environment(\.managedObjectContext) var moc
    private var deck: Deck
    @State var cards: [Card]
    @State private var chosenTest: Test
    @State private var tests: [Test]
    @State private var prompts: [Snippet]
    @State private var answers: [Snippet]
    
    init(deck: Deck) {
        /// bind everything to State so that any changes are updated
        self.deck = deck
        _cards = State(initialValue: deck._cards.sortedBy(.romaji))
        _chosenTest = State(initialValue: deck.chosenTest)
        _tests = State(initialValue: deck.testsByComplexity)
        _prompts = State(initialValue: deck.chosenTest._prompts)
        _answers = State(initialValue: deck.chosenTest._answers)
    }
    
    var body: some View {
        List {
            DeckSelection
            PracticeSelection
            Section(header: Text("Deck Information")) {
                NavigationLink("Cards", destination: CardGallery(cards: $cards, prompts: prompts, answers: answers, onDelete: onCardDeleted))
            }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationBarTitle(Text(deck._name))
    }
}

// MARK: - Practice Selection

extension DeckView {
    var PracticeSelection: some View {
        Section(header: Text("Practice")) {
            NavigationLink(
                "10 Pull",
                destination: CardSession(test: chosenTest, cards: cards, sessionType: .nPull(10))
            )
            NavigationLink(
                "Marathon All \(deck._cards.count) Cards",
                destination: CardSession(test: chosenTest, cards: cards, sessionType: .marathon)
            )
        }
        .disabled(deck._cards.count == 0)
    }
}

// MARK: - Deck Selection

extension DeckView {
    var DeckSelection: some View {
        Section(header: Text("Card Type")) {
            DisclosureGroup(chosenTest.text) {
                ForEach(tests, id: \.id) {
                    TestView($0)
                }
                NavigationLink(destination: TestCreation(completion: onTestCreated)) {
                    HStack {
                        Image(systemName: "plus")
                            .foregroundColor(.blue)
                        Text("New Test")
                    }
                }
                NavigationLink(destination: TestEdit(tests: $tests, onEdited: onTestChanged, onDeleted: onTestDeleted)) {
                    HStack {
                        Image(systemName: "pencil")
                            .foregroundColor(.blue)
                        Text("Edit Tests")
                    }
                }
            }
        }
    }
    
    func TestView(_ test: Test) -> some View {
        Button {
            chosenTest = test
            deck.chosenTest = test
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


// MARK: - Update Methods

extension DeckView {
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
    
    /// update state when a test's snippets are changed
    func onTestChanged(test: Test) -> Void {
        /// force an update by removing and reinserting the test
        tests.remove(at: tests.firstIndex(where: {$0.id == test.id})!)
        tests.append(test)
        
        if deck.chosenTest.id == test.id {
            print("fired")
            
            chosenTest = test /// update state binding
            prompts = chosenTest._prompts
            answers = chosenTest._answers
        }
        try! moc.save()
    }
    
    /// update state when a test is deleted
    func onTestDeleted(test: Test) -> Void {
        /// terminate if this would delete only test
        guard tests.count > 1 else { return }
        
        let idx = tests.firstIndex(of: test)!
        tests.remove(at: idx) /// remove local copy
        deck.removeFromTests(test) /// remove core data copy
        if deck.chosenTest == test {
            deck.chosenTest = tests.first! /// update chosen test
            chosenTest = deck.chosenTest /// and state binding
            prompts = chosenTest._prompts
            answers = chosenTest._answers
        }
        try! moc.save()
    }
    
    /// update state when a card is deleted
    func onCardDeleted(card: Card) -> Void {
        deck.removeFromCards(card) /// delete core data card
        cards.remove(at: cards.firstIndex(of: card)!) /// delete state card
        try! moc.save()
    }
}
