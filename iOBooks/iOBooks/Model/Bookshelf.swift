//
//  Bookshelf.swift
//  iOBooks
//
//  Created by Nikita Thomas on 10/29/18.
//  Copyright © 2018 Nikita Thomas. All rights reserved.
//

import Foundation


class Bookshelf: Codable {
    let name: String
    var identifier: String
    
    var books: [Book] = []
    
    init(name: String, books: [Book]) {
        (self.name, self.books, self.identifier) = (name, books, UUID().uuidString)
    }
}

