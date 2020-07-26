//
//  CollectionExtension.swift
//  Flashcard
//
//  Created by Secret Asian Man Dev on 26/7/20.
//

import Foundation

extension Collection {
    func enumeratedArray() -> Array<(offset: Int, element: Self.Element)> {
        return Array(self.enumerated())
    }
}
