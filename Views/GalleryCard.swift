//
//  GalleryCard.swift
//  Flashcard
//
//  Created by Secret Asian Man Dev on 22/7/20.
//

import SwiftUI

struct GalleryCard: View {
    
    var card: Card
    var flashcard: FlashCard
    var prompts: [Snippet]
    var answers: [Snippet]
    let index: Int
    
    @State var wiggle = Angle.zero
    @Binding var editMode: EditMode
    
    init(
        card: Card,
        index: Int,
        prompts: [Snippet],
        answers: [Snippet],
        editMode: Binding<EditMode>
    ) {
        self.card = card
        self.index = index
        self.flashcard = FlashCard(from: card)
        self.prompts = prompts
        self.answers = answers
        self._editMode = editMode
    }
    
    var body: some View {
        VStack(spacing: .zero) {
            ForEach(prompts, id: \.self) { prompt in
                Text(flashcard.contents[prompt, default: nil] ?? placeholder)
            }
            Divider()
                .padding([.leading, .trailing])
            ForEach(answers, id: \.self) { answer in
                Text(flashcard.contents[answer, default: nil] ?? placeholder)
            }
            Text("\(card.corrects) correct")
            Text("\(card.wrongs) wrong")
        }
        .background(CardBG())
        .shadow(radius: 5)
        .rotationEffect(editMode == .active ? wiggle : .zero)
        .onChange(of: editMode, perform: wiggle)
    }
    
    static let loop = Animation
        .linear(duration: 0.25)
        .repeatForever(autoreverses: true)
    
    static let wiggleSize = Angle(degrees: 3)
    
    func wiggle(mode: EditMode) -> Void {
        /// causes wiggle direction to alternate, similar to Shortcuts
        let reverse: Double = index.isMultiple(of: 2) ? +1 : -1
        /// start wiggle in opposing direction
        wiggle = -GalleryCard.wiggleSize * reverse
        withAnimation(GalleryCard.loop) {
            wiggle = (mode == .active)
                ? GalleryCard.wiggleSize * reverse
                : .zero
        }
    }
}
