//
//  ContentView.swift
//  Flashcard
//
//  Created by Secret Asian Man Dev on 19/7/20.
//

import SwiftUI

struct ContentView: View {
    @State private var cards = [Card](repeating: Card.example, count: 10)
    private let cardLimit = 3
    var body: some View {
        ZStack {
            ForEach(0..<cards.count, id: \.self) { idx in
                CardView(card: cards[idx]) {
                    removeCard(at: idx)
                }
                .stacked(at: idx, in: cards.count)
            }
        }
    }
    
    func removeCard(at index: Int) -> Void {
        withAnimation {
            cards.remove(at: index)
        }
        
        print("removed \(index)")
    }
    
    
}


extension View {
    func stacked(at position: Int, in total: Int) -> some View {
        let offset = CGFloat(total - position)
        return self.offset(CGSize(width: 0, height: offset * 10))
    }
}
