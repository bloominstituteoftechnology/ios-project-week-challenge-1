//
//  Model.swift
//  Book Project
//
//  Created by Ivan Caldwell on 12/10/18.
//  Copyright © 2018 Ivan Caldwell. All rights reserved.
//

import Foundation
class Model {
    static let shared = Model()
    private init() {}
    
    typealias UpdateHandler = () -> Void
    var updateHandler: UpdateHandler? = nil
    
    var books: [Book] = [] {
        didSet {
            DispatchQueue.main.async {
                self.updateHandler?()
            }
        }
    }
    
    // Key name for this is: "Encapsulation"
    // Hiding implementation details, which can change
    // and presenting only the API that is relevant to
    // our consumers. This is simply best programming practices.
    // Controlling and limiting my public API.
    // "A small API surface area"
    
    // Triple-slash comments provide API documentation in-line
    // that can be used within your program and by clients via libraries/frameworks
    
    /// Returns the number of books that is currently stored in the model
    func numberOfBooks() -> Int {
        return books.count
    }
    
    func book(at index: Int) -> Book {
        return books[index]
    }
    
    func search(for string: String) {
        BookAPI.searchForBooks(with: string) { books, error in
            if let error = error {
                NSLog("Error fetching books: \(error)")
                return
            }
            
            // Great opportunity to use nil coalescing to convert
            // a nil result into the empty array
            self.books = books ?? []
        }
    }
}
