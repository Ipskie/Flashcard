//
//  ContentView.swift
//  Flashcard
//
//  Created by Secret Asian Man Dev on 19/7/20.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        CardSession()
            .onAppear {
                let cards = Bundle.main.decode([Card].self, from: "Katakana.json")
            }
    }
    
}
