//
//  DeckView.swift
//  Flashcard
//
//  Created by Secret Asian Man Dev on 20/7/20.
//

import SwiftUI
import CoreData

struct DeckView: View {
    
    @Environment(\.managedObjectContext) var moc: NSManagedObjectContext
    @State private var prompt: FlashCard.Snippet
    @State private var answer: FlashCard.Snippet
    
    var deck: Deck
    
    init(deck: Deck) {
        self.deck = deck
        self._prompt = State(initialValue: deck.promptType)
        self._answer = State(initialValue: deck.answerType)
    }
    
    var body: some View {
        List {
            Section(header: Text("Practice")) {
                NavigationLink(
                    "10 Pull",
                    destination: CardSession(deck: deck, sessionType: .nPull(10))
                )
            }
            Section(header: Text("Deck Information")) {
                NavigationLink("Cards", destination: CardGallery(deck: deck))
            }
            Section(header: Text("Shown Prompt")) {
                Picker("Shown Prompt", selection: $prompt) {
                    ForEach(FlashCard.Snippet.allCases, id: \.self) {
                        Text($0.name)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            .onChange(of: prompt, perform: {
                deck.promptType = $0
                try! moc.save()
            })
            Section(header: Text("Hidden Answer")) {
                Picker("Hidden Answer", selection: $answer) {
                    ForEach(FlashCard.Snippet.allCases, id: \.self) {
                        Text($0.name)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            .onChange(of: answer, perform: {
                deck.answerType = $0
                try! moc.save()
            })
        }
        .listStyle(GroupedListStyle())
        .navigationBarTitle(Text(deck._name))
    }
}

