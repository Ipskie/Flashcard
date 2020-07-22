//
//  CardView.swift
//  Flashcard
//
//  Created by Secret Asian Man Dev on 19/7/20.
//

import SwiftUI

struct CardView: View {
    
    @State var showAnswer = false
    @State private var offset = CGSize.zero
    var card: FlashCard
    
    /// magnifies the movement of the user's swipe, so small gestures can dismiss the view
    private let scaling = CGFloat(3)
    var removal: ((FlashCard, Bool) -> Void)? = nil
    
    var body: some View {
        GeometryReader { geo in
            if geo.size.width > geo.size.height {
                HStack(spacing: .zero) {
                    Text(card.katakana ?? " – ")
                        .frame(maxWidth: geo.size.width / 2)
                        .font(.title)
                    Divider()
                        .padding([.top, .bottom])
                    Text(card.romaji ?? " – ")
                        .frame(maxWidth: geo.size.width / 2)
                        .blur(radius: showAnswer ? .zero : 10)
                        .font(.title)
                }.background(RoundedRectangle(cornerRadius: 20).fill(Color(UIColor.systemBackground)))
            } else {
                VStack(spacing: .zero) {
                    Text(card.katakana ?? " – ")
                        .frame(maxHeight: geo.size.height / 2)
                        .font(.title)
                    Divider()
                        .padding([.leading, .trailing])
                    Text(card.romaji ?? " – ")
                        .frame(maxHeight: geo.size.height / 2)
                        .blur(radius: showAnswer ? .zero : 10)
                        .font(.title)
                }.background(RoundedRectangle(cornerRadius: 20).fill(Color(UIColor.systemBackground)))
            }
        }
        .shadow(radius: 10)
        .rotationEffect(.degrees(Double(offset.width / scaling)))
        .offset(x: offset.width * scaling, y: 0)
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    offset = gesture.translation
                }
                .onEnded { _ in
                    if abs(offset.width) > 100 {
                        removal?(card, offset.width > 0)
                    } else {
                        withAnimation{ offset = .zero }
                    }
                }
        )
        .onTapGesture {
            withAnimation(.linear(duration: 0.1)) { showAnswer.toggle() }
        }
        .padding()
    }
}