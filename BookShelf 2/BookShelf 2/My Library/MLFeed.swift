//
//  ML.swift
//  BookShelf
//
//  Created by Jerrick Warren on 10/31/18.
//  Copyright © 2018 Jerrick Warren. All rights reserved.
//

import Foundation

class MLFeed: Codable, Equatable {
    
    let identifier: String
    var bookshelf: String
    var books: [Book] // try My LibraryModel if it doesn't work properly ??
    
    struct Book: Equatable, Codable {
        let title: String?
        let image: String?
        let author: String
        var reviews: [Book.Review]
        var isRead: Bool // toggle
        
        init(title:String, image:String, author:String, isRead: Bool = false) {
            self.title = title
            self.image = image
            self.author = author
            self.isRead = isRead
            self.reviews = []
        }
    
        
        struct Review: Equatable, Codable {
            let text: String
            
            init(text:String) {
                self.text = text
            }
        }
    }
        
        init(bookshelf: String){
            self.identifier = UUID().uuidString
            self.bookshelf = bookshelf
            self.books = []
        }
    
    static func == (lhs: MLFeed, rhs: MLFeed) -> Bool {
        return lhs.identifier == rhs.identifier && lhs.bookshelf == rhs.bookshelf && rhs.books == lhs.books
    }
    
    required init(from decoder: Decoder) throws {
        
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        
        let bookshelf = try container.decode(String.self, forKey: .bookshelf)
        let identifier = try container.decode(String.self, forKey: .identifier)
        let bookDictionaries = try container.decodeIfPresent([String: Book].self, forKey: .books)
        
        // do I need to make a reviews Library?  We will see.
//        let reviewDictionaries = try container.decodeIfPresent([String: Book.Review].self, forKey: MyLibraryModel.Book.review)
        
        let book = bookDictionaries?.compactMap({ $0.value }) ?? []
        
        
        self.bookshelf = bookshelf
        self.identifier = identifier
        self.books = book
        
    }
    
    // Firebase JSON

    
    struct MLBookResults {
        var mLBooks : [MLFeed]
    }
    
    
    
}
