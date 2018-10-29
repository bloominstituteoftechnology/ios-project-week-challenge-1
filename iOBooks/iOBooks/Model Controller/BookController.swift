//
//  BookController.swift
//  iOBooks
//
//  Created by Nikita Thomas on 10/29/18.
//  Copyright © 2018 Nikita Thomas. All rights reserved.
//

import UIKit

class BookController {
    static var shared = BookController()
    private init() {}
    
    var bookSearch: BookSearch?
    var bookshelves: [Bookshelf] = []
    
    func newBook(name: String, image: String) -> Book {
        return Book(name: name, image: image)
    }
    
    func newShelf(name: String, books: [Book]) {
        let shelf = Bookshelf(name: name, books: books)
        bookshelves.append(shelf)
    }

    func search(term: String, completion: @escaping () -> Void = {}) {
        guard
            let baseURL = URL(string: "https://www.googleapis.com/books/v1/volumes"),
            var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
            else {
                fatalError("Unable to setup url and components")
        }
        
        components.queryItems = [URLQueryItem(name: "q", value: term)]
        
        guard let url = components.url else {return}
        
        let dataTask = URLSession.shared.dataTask(with: url) { data, _, error in
            guard error == nil, let data = data else {
                NSLog("Could not run datatask")
                completion()
                return
            }
            
            do {
                let searchResults = try JSONDecoder().decode(BookSearch.self, from: data)
                self.bookSearch = searchResults
                completion()
                return
            } catch {
                print(url)
                NSLog("Could not decode JSON into BookSearch objects")
                completion()
                return
            }
        }
        dataTask.resume()

    }
    
    
}

