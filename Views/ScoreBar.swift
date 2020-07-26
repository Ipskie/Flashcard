//
//  ScoreBar.swift
//  Flashcard
//
//  Created by Secret Asian Man Dev on 26/7/20.
//

import SwiftUI

struct ScoreBar: View {
    
    let pCorrect: CGFloat
    
    /// value indicating that no score is available
    let flag = CGFloat.greatestFiniteMagnitude
    
    init(corrects: Int, wrongs: Int) {
        if corrects + wrongs == .zero {
            pCorrect = flag
        } else {
            pCorrect = CGFloat(corrects) / CGFloat(corrects + wrongs)
        }
    }
    
    var body: some View {
        switch pCorrect == flag {
        case true:
            Text("No Score")
                .font(.footnote)
                .multilineTextAlignment(.center)
        case false:
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
    }
    
    var percentage: String {
        (pCorrect != flag) ? "\(Int(pCorrect * 100))%" : " – "
    }
}
