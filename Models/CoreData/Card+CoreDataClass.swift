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
        hiragana = flash.hiragana
        katakana = flash.katakana
        romaji = flash.romaji
        kanji = flash.kanji
        english = flash.english
        history = flash.history.toString()
        comfortable = flash.comfortable
        self.deck = deck
    }
}
