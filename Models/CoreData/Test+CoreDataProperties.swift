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
    @NSManaged var history: String?
    @NSManaged var deck: Deck?

}
