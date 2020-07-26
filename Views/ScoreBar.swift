//
//  ScoreBar.swift
//  Flashcard
//
//  Created by Secret Asian Man Dev on 26/7/20.
//

import SwiftUI

struct ScoreBar: View {
    
    let pCorrect: CGFloat
    
    init(corrects: Int, wrongs: Int) {
        if corrects + wrongs == .zero {
            pCorrect = .nan
        } else {
            pCorrect = CGFloat(corrects) / CGFloat(corrects + wrongs)
        }
    }
    
    var body: some View {
        if (pCorrect == .nan) {
            Text("No Score")
        } else {
            ScoreView
        }
    }
    
    var ScoreView: some View {
        VStack {
            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: geo.size.height / 2)
                        .foregroundColor(.green)
                        .frame(width: geo.size.width * pCorrect)
                    RoundedRectangle(cornerRadius: geo.size.height / 2)
                        .stroke(Color.black)
                }
            }
            Text(percentage)
                .font(.footnote)
        }
    }
    
    var percentage: String {
        (pCorrect == .nan) ? "\(Int(pCorrect * 100))%" : " – "
    }
}
