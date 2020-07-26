//
//  Deck+CoreDataClass.swift
//  Flashcard
//
//  Created by Secret Asian Man Dev on 24/7/20.
//
//

import Foundation
import CoreData

fileprivate struct RawDeck: Decodable {
    let name: String
    let cards: Set<Card>
    let tests: Set<Test>?
}

@objc(Deck)
public class Deck: NSManagedObject, Codable {
    
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
        self.chosenTest = tests.first! // choose the first test by default
    }
    
    public required init(from decoder: Decoder) throws {
        /// get required context
        guard let context = decoder.userInfo[.context] as? NSManagedObjectContext else { fatalError("NSManagedObjectContext is missing") }
        super.init(entity: Deck.entity(), insertInto: context)
        
        id = UUID()
    
        /// pipe through RawCard
        let rawDeck = try RawDeck(from: decoder)
        name = rawDeck.name
        cards = rawDeck.cards as NSSet /// note: should assign inverse card -> deck relationship
        if let newTests = rawDeck.tests, !newTests.isEmpty {
            tests = newTests as NSSet
        } else {
            #warning("add automatic test construction in future")
            tests = [Test(moc: context)] /// throw it a simple test
        }
        chosenTest = _tests.first!
    }
}
