//
//  ContentView.swift
//  Flashcard
//
//  Created by Secret Asian Man Dev on 19/7/20.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        CardSession(cards: Bundle.main.decode([FlashCard].self, from: "Katakana.json"))
    }
    
}
