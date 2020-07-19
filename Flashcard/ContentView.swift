//
//  ContentView.swift
//  Flashcard
//
//  Created by Secret Asian Man Dev on 19/7/20.
//

import SwiftUI

struct ContentView: View {
    @State private var cards = [Card](repeating: Card.example, count: 10)
    var body: some View {
        CardView(card: Card(prompt: "Prompt", answer: "Answer"))
            .padding()
            .border(Color.red)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
