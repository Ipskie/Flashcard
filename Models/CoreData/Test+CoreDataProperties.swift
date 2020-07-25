//
//  Test+CoreDataProperties.swift
//  Flashcard
//
//  Created by Secret Asian Man Dev on 24/7/20.
//
//

import Foundation
import CoreData


extension Test {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Test> {
        return NSFetchRequest<Test>(entityName: "Test")
    }

    @NSManaged public var prompts: [Int]
    @NSManaged public var answers: [Int]
    
    @NSManaged public var id: UUID?
    @NSManaged public var deck: Deck?
    @NSManaged public var history: NSSet?

    // MARK: - Accessors & Mutators
    var _prompts: [Snippet] {
        get {
            prompts.map{Snippet(rawValue: $0)!} /// force unwrap from raw values
        }
        set {
            prompts = newValue.map{$0.rawValue}
        }
    }
    
    var _answers: [Snippet] {
        get {
            answers.map{Snippet(rawValue: $0)!} /// force unwrap from raw values
        }
        set {
            answers = newValue.map{$0.rawValue}
        }
    }
}

// MARK: Generated accessors for history
extension Test {

    @objc(addHistoryObject:)
    @NSManaged public func addToHistory(_ value: History)

    @objc(removeHistoryObject:)
    @NSManaged public func removeFromHistory(_ value: History)

    @objc(addHistory:)
    @NSManaged public func addToHistory(_ values: NSSet)

    @objc(removeHistory:)
    @NSManaged public func removeFromHistory(_ values: NSSet)

}
