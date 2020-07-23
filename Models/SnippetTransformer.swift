//
//  SnippetTransformer.swift
//  Flashcard
//
//  Created by Secret Asian Man Dev on 23/7/20.
//

import Foundation

class SnippetTransformer: ValueTransformer {
    /// archive as Data
    override func transformedValue(_ value: Any?) -> Any? {
        try! NSKeyedArchiver.archivedData(withRootObject: value!, requiringSecureCoding: true)
    }
    
    /// archive must be reversible!
    override class func allowsReverseTransformation() -> Bool {
        return true
    }
    
    override func reverseTransformedValue(_ value: Any?) -> Any? {
        try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(value as! Data) as? [Snippet]
    }
}

extension NSValueTransformerName {
    static let snippetTransformerName = NSValueTransformerName(rawValue: "SnippetTransformer")
}
