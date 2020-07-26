//
//  History+CoreDataClass.swift
//  Flashcard
//
//  Created by Secret Asian Man Dev on 24/7/20.
//
//

import Foundation
import CoreData

@objc(History)
public class History: NSManagedObject {
    
    static let entityName = "History" /// for making entity calls
    
    @objc
    private override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }
    
    init(moc: NSManagedObjectContext, test: Test, card: Card, correct: Bool) {
        super.init(entity: History.entity(), insertInto: moc)
        self.test = test
        self.card = card
        self.correct = correct
        self.date = Date()
    }
    
}
