//
//  Deck+CoreDataClass.swift
//  Flashcard
//
//  Created by Secret Asian Man Dev on 24/7/20.
//
//

import Foundation
import CoreData

@objc(Deck)
public class Deck: NSManagedObject {
    
    static let entityName = "Deck" /// for making entity calls
    
    @objc
    private override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }
    
    init(moc: NSManagedObjectContext, name: String, cards: Set<Card>, tests: Set<Test>) {
        precondition(tests.count > 0, "Deck needs at least 1 test!")
        super.init(entity: Deck.entity(), insertInto: moc)
        self.id = UUID()
        self.name = name
        self.cards = cards as NSSet
        self.tests = tests as NSSet
        self.testID = tests.first!.id // choose the first test by default
    }
}
