//
//  CardView.swift
//  Flashcard
//
//  Created by Secret Asian Man Dev on 19/7/20.
//

import SwiftUI

struct CardView: View {
    var card: Card
    @State var showAnswer = false
    
    var body: some View {
        GeometryReader { geo in
            HStack(spacing: .zero) {
                Text(card.prompt)
                    .frame(width: geo.size.width / 2)
                    .font(.title)
                Divider()
                    .padding([.top, .bottom])
                Text(card.answer)
                    .frame(width: geo.size.width / 2)
                    .blur(radius: showAnswer ? .zero : 10)
                    .font(.title)
            }
            .background(
                RoundedRectangle(cornerRadius: geo.size.height / 8)
                    .fill(Color(UIColor.systemBackground))
                )
            .shadow(radius: 10)
            .onTapGesture {
                withAnimation(.linear(duration: 0.1)) { showAnswer.toggle() }
            }
        }
    }
    
}
