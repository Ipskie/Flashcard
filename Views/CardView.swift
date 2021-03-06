//
//  CardView.swift
//  Flashcard
//
//  Created by Secret Asian Man Dev on 19/7/20.
//

import SwiftUI

struct CardView: View {
    
    /// magnifies the movement of the user's swipe, so small gestures can dismiss the view
    private let scaling = CGFloat(3)
    
    @State var showAnswer = false
    @State private var offset = CGSize.zero
    
    var card: FlashCard
    var prompts: [Snippet]
    var answers: [Snippet]
    var removal: ((FlashCard, Bool) -> Void)? = nil
    
    var body: some View {
        GeometryReader { geo in
            if geo.size.width > geo.size.height {
                HCard(geo: geo)
                    .background(CardBG())
            } else {
                VCard(geo: geo)
                    .background(CardBG())
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
    
    func VCard(geo: GeometryProxy) -> some View {
        VStack(spacing: .zero) {
            VStack { card.texts(for: prompts, font: .title) }
                .frame(maxHeight: geo.size.height / 2)
            Divider()
                .padding([.leading, .trailing])
            VStack { card.texts(for: answers, font: .title) }
                .frame(maxHeight: geo.size.height / 2)
                .blur(radius: showAnswer ? .zero : 10)
        }
    }
    
    func HCard(geo: GeometryProxy) -> some View {
        HStack(spacing: .zero) {
            VStack { card.texts(for: prompts, font: .title) }
                .frame(maxWidth: geo.size.width / 2)
            Divider()
                .padding([.top, .bottom])
            VStack { card.texts(for: answers, font: .title) }
                .frame(maxWidth: geo.size.width / 2)
                .blur(radius: showAnswer ? .zero : 10)
        }
    }
}
