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
    
    func loadDeck() -> Void {
        /// request a single JSON type file from the user
        importAction(singleOfType: [.json]) { result in
            var deckResult: Result<Deck, FileError>? = nil
            switch result {
            case .success(let url):
                precondition(url.isFileURL, "Received a non file URL!")
                print("Success: \(url)")
                do {
                    /// ask for system permission to access secure resource
                    _ = url.startAccessingSecurityScopedResource()
                    defer { url.stopAccessingSecurityScopedResource() }
                    
                    /// decode from JSON
                    let data = try Data(contentsOf: url)
                    let decoder = JSONDecoder(context: moc)
                    let deck = try! decoder.decode(Deck.self, from: data)
                    try! moc.save()
                    
                    deckResult = .success(deck)
                } catch {
                    deckResult = .failure(.other(error))
                }
            case.failure(let error):
                deckResult = .failure(.other(error))
            case .none:
                deckResult = .failure(.cancelled)
            }
            
            /// if failed, show me what happened
            if case let .failure(error) = deckResult {
                print(error)
            }
        }
    }
}
