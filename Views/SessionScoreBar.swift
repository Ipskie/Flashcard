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
    
    init(rights: Int, wrongs: Int, freshs: Int) {
        pRight = CGFloat(rights) / CGFloat(rights + wrongs + freshs)
        pWrong = CGFloat(wrongs) / CGFloat(rights + wrongs + freshs)
        pFresh = CGFloat(freshs) / CGFloat(rights + wrongs + freshs)
    }
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}
