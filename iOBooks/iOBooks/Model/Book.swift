//
//  Book.swift
//  iOBooks
//
//  Created by Nikita Thomas on 10/29/18.
//  Copyright © 2018 Nikita Thomas. All rights reserved.
//

import Foundation


struct Book {
    let name: String
    let image: String
    var review: String?
    var read: Bool
    
    var bookshelves: [Bookshelf] = []
    
    init(name: String, image: String, review: String? = "", read: Bool = false) {
        (self.name, self.image, self.review, self.read) = (name, image, review, read)
    }
}
