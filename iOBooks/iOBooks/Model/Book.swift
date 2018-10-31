//
//  Book.swift
//  iOBooks
//
//  Created by Nikita Thomas on 10/29/18.
//  Copyright © 2018 Nikita Thomas. All rights reserved.
//

import Foundation


class Book: Codable {
    let name: String
    let image: String?
    var review: String
    var read: Bool
    
    // bookshelf identifiers
    var bookshelves: [String] = []
    
    init(name: String, image: String, review: String = "", read: Bool = false) {
        (self.name, self.image, self.review, self.read) = (name, image, review, read)
    }
}


struct BookStub: Codable {
    let name: String
    let image: String?
    var review: String
    var read: Bool
    
    var bookshelves: [String] = []
    
    init(name: String, image: String, review: String, read: Bool, bookshelves: [String]) {
        (self.name, self.image, self.review, self.read, self.bookshelves) = (name, image, review, read, bookshelves)
    }
}
