//
//  SessionScoreBar.swift
//  Flashcard
//
//  Created by Secret Asian Man Dev on 27/7/20.
//

import SwiftUI

struct SessionScoreBar: View {
    let pRight: CGFloat
    let pWrong: CGFloat
    let pFresh: CGFloat
    
    @Environment(\.accessibilityDifferentiateWithoutColor) var dwc
    
    init?(rights: Int, wrongs: Int, freshs: Int) {
        print(rights, wrongs, freshs)
        guard (rights + wrongs + freshs > 0) else { return nil }
        pRight = CGFloat(rights) / CGFloat(rights + wrongs + freshs)
        pWrong = CGFloat(wrongs) / CGFloat(rights + wrongs + freshs)
        pFresh = CGFloat(freshs) / CGFloat(rights + wrongs + freshs)
    }
    var body: some View {
        HStack {
            if dwc { Image(systemName: "checkmark.circle").foregroundColor(.green) }
            ColorBars
            if dwc { Image(systemName: "xmark.circle").foregroundColor(.red) }
        }
        .frame(maxHeight: 20)
        .padding()
    }
    
    var ColorBars: some View {
        GeometryReader { geo in
            HStack(spacing: .zero) {
                RoundedRectangle(cornerRadius: geo.size.height / 2)
                    .foregroundColor(.green)
                    .frame(width: geo.size.width * pRight)
                RoundedRectangle(cornerRadius: geo.size.height / 2)
                    .stroke(Color.black)
                    .frame(width: geo.size.width * pFresh)
                RoundedRectangle(cornerRadius: geo.size.height / 2)
                    .foregroundColor(.red)
                    .frame(width: geo.size.width * pWrong)
            }
        }
        
        
    }
}
