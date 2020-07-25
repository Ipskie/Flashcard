//
//  Test+CoreDataClass.swift
//  Flashcard
//
//  Created by Secret Asian Man Dev on 24/7/20.
//
//

import Foundation
import CoreData

@objc(Test)
public class Test: NSManagedObject {
    
    static let entityName = "Test" /// for making entity calls
    
    @objc
    private override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }

    init(moc: NSManagedObjectContext, prompts: [Snippet], answers: [Snippet]) {
        super.init(entity: Test.entity(), insertInto: moc)
        self.id = UUID()
        self.prompts = prompts.map{$0.rawValue}
        self.answers = answers.map{$0.rawValue}
        self.history = []
    }
}
