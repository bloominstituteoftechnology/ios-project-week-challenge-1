//
//  Bookshelf.swift
//  iOBooks
//
//  Created by Nikita Thomas on 10/29/18.
//  Copyright © 2018 Nikita Thomas. All rights reserved.
//

import Foundation


class Bookshelf {
    let name: String
    var books: [Book] = []
    
    init(name: String, books: [Book]) {
        (self.name, self.books) = (name, books)
    }
}
