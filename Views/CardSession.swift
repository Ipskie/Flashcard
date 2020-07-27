//
//  CardSession.swift
//  Flashcard
//
//  Created by Secret Asian Man Dev on 19/7/20.
//

import SwiftUI
import CoreData

struct CardSession: View {
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    @State private var cards: [FlashCard] = []
    private var test: Test
    enum CardStatus {
        case right
        case wrong
        case fresh /// not yet encountered
    }
    
    @State private var cardsStatus: [NSManagedObjectID:CardStatus]
    
    enum SessionType {
        case nPull(Int) // pull only an integer number of cards. no repeats
        case marathon // pull every card in the deck
        case training // pull any card in the deck, but allow repeats of wrong cards
    }
    
    var sessionType: SessionType
    
    private var prompts: [Snippet]
    private var answers: [Snippet]
    
    init(test: Test, cards: [Card], sessionType: SessionType) {
        self.test = test
        self.sessionType = sessionType
        #warning("variable here for whether or not to cycle cards")
        
        _cards = State(initialValue: getCards(cards: cards, mode: sessionType))
        prompts = test._prompts
        answers = test._answers
        /// assign every card as not yet encountered
        var cDict = [NSManagedObjectID:CardStatus]()
        cards.forEach{cDict[$0.objectID] = .fresh}
        _cardsStatus = State(initialValue: cDict)
    }
    
    var body: some View {
        VStack {
            ZStack {
                ForEach(cards, id: \.id) { card in
                    CardView(
                        card: card,
                        prompts: prompts,
                        answers: answers,
                        removal: remove
                    )
                        .stacked(
                            at: cards.firstIndex(where: {$0.id == card.id})!,
                            in: cards.count
                        )
                }
            }
            SessionScoreBar(
                rights: cardsStatus.filter{$0.value == .right}.count,
                wrongs: cardsStatus.filter{$0.value == .wrong}.count,
                freshs: cardsStatus.filter{$0.value == .fresh}.count
            )
        }
        .navigationBarHidden(true)
        .onChange(of: cards){
            guard $0.count == 0 else { return }
            /// on exit, save changes to card history
            try! moc.save()
            presentationMode.wrappedValue.dismiss()
        }
    }
    
    func remove(card: FlashCard, correct: Bool) -> Void {
        let oid = card.objID! /// get core data Object ID for corresponding Card
        
        withAnimation {
            cardsStatus[oid] = correct ? .right : .wrong
        }
        
        /// fetch corresponding card from core data
        let CDcard = moc.object(with: oid) as! Card
        
        /// synthesize and insert new history entry
        let historyEntry = History(moc: moc, correct: correct)
        CDcard.addToHistory(historyEntry)
        test.addToHistory(historyEntry)
        try! moc.save()
        
        withAnimation {
            let card = cards.remove(at: cards.firstIndex(where: {$0.id == card.id})!)
            if !correct {
                /// if it was the last card, just stop
                guard cards.count > 1 else { return }
                /// re-insert the card at a random index
                cards.insert(
                    FlashCard(from: moc.object(with: card.objID!) as! Card),
                    at: Int.random(in: 1..<cards.count)
                )
            }
        }
    }
    
    
}

/// return the appropriate number of cards, in shuffled order
func getCards(cards: [Card], mode: CardSession.SessionType) -> [FlashCard] {
    var flashcards = cards.map{FlashCard(from: $0)}.shuffled()
    if case let .nPull(count) = mode {
        flashcards = Array(flashcards.prefix(upTo: min(count, flashcards.count))) /// pull at most `count` cards
    }
    return flashcards
}

