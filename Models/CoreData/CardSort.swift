//
//  CardSort.swift
//  Flashcard
//
//  Created by Secret Asian Man Dev on 22/7/20.
//

import Foundation

extension Set where Element == Card {
    /// ways to order Cards
    enum order {
        case romaji
        case comfortable
    }
    /// a convenient way to request cards sorted in a certain order
    func sortedBy(_ sort: Set<Card>.order) -> [Card] {
        switch sort {
        case .romaji:
            return self.sorted(by: {($0.romaji ?? "") < ($1.romaji ?? "")})
        case .comfortable:
            return self.sorted(by: {$0.comfortable && !($1.comfortable)})
        }
    }
}
