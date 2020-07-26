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
    @State private var test: Test
    @State private var prompts: [Snippet]
    @State private var answers: [Snippet]
    
    init(deck: Deck) {
        /// bind everything to State so that any changes are updated
        _deck = State(initialValue: deck)
        _test = State(initialValue: deck.chosenTest)
        _prompts = State(initialValue: deck.chosenTest._prompts)
        _answers = State(initialValue: deck.chosenTest._answers)
    }
    
    var body: some View {
        List {
            Section(header: Text("Card Type: ")) {
                NavigationLink(destination: SnippetPicker(
                    prompts: $prompts,
                    answers: $answers
                )) {
                    Text(test._prompts.map{$0.name}.joined(separator: " + ")
                         + " ➜ "
                         + test._answers.map{$0.name}.joined(separator: " + ")
                    )
                }
                /// detect changes through binding
                .onChange(of: prompts) {
                    test._prompts = $0
                    deck.chosenTest = test
                    try! moc.save()
                }
                .onChange(of: answers) {
                    test._answers = $0
                    deck.chosenTest = test
                    try! moc.save()
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
}

