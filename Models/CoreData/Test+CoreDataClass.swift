//
//  Test+CoreDataClass.swift
//  Flashcard
//
//  Created by Secret Asian Man Dev on 24/7/20.
//
//

import Foundation
import CoreData

fileprivate struct RawTest: Decodable {
    let prompts: [Int]
    let answers: [Int]
}

@objc(Test)
public class Test: NSManagedObject, Codable {
    
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
        
        /// initializes with no history
        self.history = []
    }
    
    /// initialize a simple Test, defaulting to Hiragana -> Romaji
    convenience init (moc: NSManagedObjectContext) {
        self.init(
            moc: moc,
            prompts: defaultPrompt,
            answers: defaultAnswer
        )
    }
    
    public required init(from decoder: Decoder) throws {
        /// get required context
        guard let context = decoder.userInfo[.context] as? NSManagedObjectContext else { fatalError("NSManagedObjectContext is missing") }
        super.init(entity: Test.entity(), insertInto: context)
        
        id = UUID()
        
        /// pipe through RawCard
        let rawTest = try RawTest(from: decoder)
        prompts = rawTest.prompts
        answers = rawTest.answers
        
        /// Note: Tests should only be decoded when a RawDeck is decoded, hence a deck is always assigned
    }
}
