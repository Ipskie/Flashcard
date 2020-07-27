//
//  StackedCard.swift
//  Flashcard
//
//  Created by Secret Asian Man Dev on 27/7/20.
//

import SwiftUI
extension View {
    
    /// styling modifier to make cards look like they are "stacked" on top of each other
    func stacked(at position: Int, in total: Int) -> some View {
        var scale = CGFloat.zero
        switch total - position {
        case 1: scale = 1 /// current card
        case 2: scale = 0.8 /// next card
        default: scale = 0.5 /// all other cards
        }
        /// add 1 due to zero indexing, so front card is always 100% of size
        return self
            .scaleEffect(scale)
    }
}
