//
//  LoadDeck.swift
//  Flashcard
//
//  Created by Secret Asian Man Dev on 26/7/20.
//

import Foundation

extension DeckSelect {
    
    enum FileError: Error {
        case cancelled /// user cancelled out of the file dialog
        case other(Error)
    }
    
    func loadDeck() -> Result<Deck, FileError> {
        /// request a single JSON type file from the user
        var deckResult: Result<Deck, FileError>!
        importAction(singleOfType: [.json]) { result in
            switch(result){
            case .success(let url):
                precondition(url.isFileURL, "Received a non file URL!")
                print("Success: \(url)")
                do {
                    _ = url.startAccessingSecurityScopedResource()
                    let s = try String(contentsOf: url)
                    url.stopAccessingSecurityScopedResource()
                } catch {
                    deckResult = .failure(.other(error))
                }
            case.failure(let error):
                deckResult = .failure(.other(error))
            case .none:
                deckResult = .failure(.cancelled)
            }
        }
        return deckResult
    }
}
