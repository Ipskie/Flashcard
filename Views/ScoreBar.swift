//
//  ScoreBar.swift
//  Flashcard
//
//  Created by Secret Asian Man Dev on 26/7/20.
//

import SwiftUI

struct ScoreBar: View {
    
    let pCorrect: CGFloat
    let pWrong: CGFloat
    
    init(corrects: Int, wrongs: Int) {
        pCorrect = CGFloat(corrects) / CGFloat(corrects + wrongs)
        pWrong = CGFloat(wrongs) / CGFloat(corrects + wrongs)
    }
    
    var body: some View {
        VStack {
            
            GeometryReader { geo in
                HStack(spacing: .zero) {
                    RoundedRectangle(cornerRadius: geo.size.height / 2)
                        .foregroundColor(.green)
                        .frame(width: geo.size.width * pCorrect)
                    Divider()
                    RoundedRectangle(cornerRadius: geo.size.height / 2)
                        .foregroundColor(.red)
                        .frame(width: geo.size.width * pWrong)
                }
            }
            Text("\(Int(pCorrect * 100))%")
                .font(.footnote)
        }
    }
}
