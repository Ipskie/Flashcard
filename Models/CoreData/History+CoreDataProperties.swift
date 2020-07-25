//
//  History+CoreDataProperties.swift
//  Flashcard
//
//  Created by Secret Asian Man Dev on 24/7/20.
//
//

import Foundation
import CoreData


extension History {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<History> {
        return NSFetchRequest<History>(entityName: "History")
    }

    @NSManaged public var history: NSObject?
    @NSManaged public var test: Test?
    @NSManaged public var card: Card?

}
