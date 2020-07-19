//
//  ContentView.swift
//  Flashcard
//
//  Created by Secret Asian Man Dev on 19/7/20.
//

import SwiftUI

struct ContentView: View {
    @State private var cards = [Card]()
    private let cardLimit = 3
    
    var body: some View {
        ZStack {
            ForEach(cards, id: \.id) { card in
                CardView(card: card) {
                    remove()
                }
                .stacked(at: cards.firstIndex(where: {$0.id == card.id})!, in: cards.count)
            }
        }
        .onAppear{
            (0..<10).forEach{
                cards.append(Card(prompt: "\($0)", answer: "\($0)"))
                print($0)
            }
            cards.shuffle()
        }
    }
    
    func remove() -> Void {
        withAnimation {
            let card = cards.removeLast()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.001) {
                cards.insert(
                    Card(prompt: card.prompt, answer: card.answer),
                    at: Int.random(in: 1..<cards.count)
                )
            }
            print("removed \(card.prompt)")
        }
    }
    
    
}


extension View {
    func stacked(at position: Int, in total: Int) -> some View {
        let offset = CGFloat(total - position)
        return self.offset(CGSize(width: 0, height: offset * 10))
    }
}
