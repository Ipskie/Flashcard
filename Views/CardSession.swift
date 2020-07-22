//
//  CardSession.swift
//  Flashcard
//
//  Created by Secret Asian Man Dev on 19/7/20.
//

import SwiftUI

struct CardSession: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State private var cards: [FlashCard]
    
    enum SessionType {
        case nPull(Int) // pull only an integer number of cards. no repeats
        case marathon // pull every card in the deck
        case training // pull any card in the deck, but allow repeats of wrong cards
    }
    
    var deck: Deck
    var sessionType: SessionType
    
    init(deck: Deck, sessionType: SessionType) {
        self.deck = deck
        self.sessionType = sessionType
        #warning("variable here for whether or not to cycle cards")
        _cards = State(initialValue: deck.flashcards)
        print(deck.flashcards)
        print(self.cards)
    }
    
    var body: some View {
        ZStack {
            ForEach(cards, id: \.id) { card in
                CardView(
                    card: card,
                    prompt: deck.promptType,
                    answer: deck.answerType,
                    removal: remove
                )
                    .stacked(
                        at: cards.firstIndex(where: {$0.id == card.id})!,
                        in: cards.count
                    )
            }
        }
        .onChange(of: cards){
            guard $0.count == 0 else { return }
            presentationMode.wrappedValue.dismiss()
        }
    }
    
    func remove(card: FlashCard, correct: Bool) -> Void {
        withAnimation {
            let card = cards.remove(at: cards.firstIndex(where: {$0.id == card.id})!)
            if !correct {
                /// if it was the last card, just stop
                guard cards.count > 1 else { return }
                /// re-insert the card at a random index
                cards.insert(
                    card.copy(),
                    at: Int.random(in: 1..<cards.count)
                )
            }
        }
    }
}


extension View {
    func stacked(at position: Int, in total: Int) -> some View {
        var scale = CGFloat.zero
        switch total - position {
        case 1: scale = 1 /// current card
        case 2: scale = 0.8 /// next card
        default: scale = 0.5 /// all other cards
        }
        /// add 1 due to zero indexing, so front card is always 100% of size
        return self
            .scaleEffect(scale)
    }
}
