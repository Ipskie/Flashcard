//
//  Card+CoreDataClass.swift
//  Flashcard
//
//  Created by Secret Asian Man Dev on 19/7/20.
//
//

import Foundation
import CoreData

@objc(Card)
public class Card: NSManagedObject {
    
    static let entityName = "Card" /// for making entity calls
    
    @objc
    private override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }
    
    init(context: NSManagedObjectContext, flash: FlashCard, deck: Deck) {
        super.init(entity: Card.entity(), insertInto: context)
        id = flash.id
        
        hiragana = flash.contents[.hiragana, default: nil]
        katakana = flash.contents[.katakana, default: nil]
        romaji = flash.contents[.romaji, default: nil]
        kanji = flash.contents[.kanji, default: nil]
        english = flash.contents[.english, default: nil]
        
        comfortable = flash.comfortable
        self.deck = deck
    }
}
