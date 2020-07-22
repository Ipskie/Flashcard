//
//  BoolTransformer.swift
//  Flashcard
//
//  Created by Secret Asian Man Dev on 19/7/20.
//

import Foundation

extension Array where Element == Bool {
    /// serialize as T's and F's
    func toString() -> String {
        self.reduce("", {$0 + ($1 ? "T" : "F")})
    }
    
    /// get an array of booleans from a string of T's and F's
    init(from string: String) {
        self.init()
        string.forEach{ char in
            switch char {
            case "T":
                self.append(true)
            case "F":
                self.append(false)
            default:
                fatalError("Could not turn \(char) into a boolean!")
            }
        }
    }
    
    /// count number of "wrong" answers, or falses
    var wrongs: Int {
        self.filter{!$0}.count
    }
    
    /// count number of "right" answers, or trues
    var corrects: Int {
        self.filter{$0}.count
    }
}
