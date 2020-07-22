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
    var prompt: String?
    var answer: String?
    var removal: ((FlashCard, Bool) -> Void)? = nil
    
    init(
        card: FlashCard,
        prompt: FlashCard.Snippet,
        answer: FlashCard.Snippet,
        removal: ((FlashCard, Bool) -> Void)? = nil
    ) {
        self.card = card
        self.removal = removal
        self.prompt = card.contents[prompt, default: nil]
        self.answer = card.contents[answer, default: nil]
    }
    
    
    var body: some View {
        GeometryReader { geo in
            if geo.size.width > geo.size.height {
                HCard(geo: geo)
                    .background(RoundedRectangle(cornerRadius: 20).fill(Color(UIColor.systemBackground)))
            } else {
                VCard(geo: geo)
                    .background(RoundedRectangle(cornerRadius: 20).fill(Color(UIColor.systemBackground)))
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
            PromptText
                .frame(maxHeight: geo.size.height / 2)
            Divider()
                .padding([.leading, .trailing])
            AnswerText
                .frame(maxHeight: geo.size.height / 2)
                .blur(radius: showAnswer ? .zero : 10)
        }
    }
    
    func HCard(geo: GeometryProxy) -> some View {
        HStack(spacing: .zero) {
            PromptText
                .frame(maxWidth: geo.size.width / 2)
            Divider()
                .padding([.top, .bottom])
            AnswerText
                .frame(maxWidth: geo.size.width / 2)
                .blur(radius: showAnswer ? .zero : 10)
        }
    }
    
    var PromptText: Text {
        Text(prompt ?? "blank")
            .foregroundColor((prompt == nil) ? .primary : Color(UIColor.placeholderText))
            .font(.title)
    }
    
    var AnswerText: Text {
        Text(answer ?? "blank")
            .foregroundColor((answer == nil) ? .primary : Color(UIColor.placeholderText))
            .font(.title)
    }
}
