//
//  Test+CoreDataProperties.swift
//  Flashcard
//
//  Created by Secret Asian Man Dev on 23/7/20.
//
//

import Foundation
import CoreData


extension Test {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Test> {
        return NSFetchRequest<Test>(entityName: "Test")
    }

    @NSManaged var prompts: [Int]
    @NSManaged var answers: [Int]
    @NSManaged var history: [Bool]
    @NSManaged var deck: Deck?
    
    /// force unwrap stored enums
    var _prompts: [Snippet] {
        prompts.map{Snippet(rawValue: $0)!}
    }
    
    /// force unwrap stored enums
    var _answers: [Snippet] {
        answers.map{Snippet(rawValue: $0)!}
    }
}
