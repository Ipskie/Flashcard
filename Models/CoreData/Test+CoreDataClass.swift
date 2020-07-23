//
//  Test+CoreDataClass.swift
//  Flashcard
//
//  Created by Secret Asian Man Dev on 23/7/20.
//
//

import Foundation
import CoreData

@objc(Test)
public class Test: NSManagedObject {
    
    @objc
    private override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }
    
    /// create a Core Data deck by unpacking it from a bundled JSON file
    init(prompts: [Snippet], answers: [Snippet], context: NSManagedObjectContext) throws {
        super.init(entity: Test.entity(), insertInto: context)
        self.prompts = prompts.map{$0.rawValue}
        self.answers = answers.map{$0.rawValue}
    }
    
}
