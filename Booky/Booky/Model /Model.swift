//
//  Model.swift
//  Booky
//
//  Created by Madison Waters on 12/10/18.
//  Copyright © 2018 Jonah Bergevin. All rights reserved.
//

import UIKit

class Model {
    
    static var shared = Model()
    private init() {}
    
    var delegate: ModelUpdateClient?
    
    var bookshelf: Bookshelf?
    var bookshelfNames: [String] = []
    var bookshelves: [Bookshelf] = []
    
    var book: Book?
    
    var books: [Book] = []
    
    func numberOfBookshelves() -> Int {
        return bookshelves.count
    }
    
    func numberOfBooks() -> Int {
        return books.count
    }
    
    func getBook(at index: Int) -> Book {
        return books[index]
    }
    
    func addBook(_ book: Book)  {
        books.append(book)
    }
    
    //MARK: - Google Books API
    func search(for volume: String, completion: @escaping () -> Void ) {
        GoogleBooksAPI.searchForBooks(with: volume) { (books, error) in
            if let error = error {
                NSLog("Error fetching Book: \(error)")
                completion()
            }
            
            if let books = books {
                self.books = books
            }
            completion()
        }
    }
    
    //MARK: - Firebase Methods
    
    func add(bookshelf: Bookshelf, completion: @escaping () -> Void ) {
        bookshelves.append(bookshelf)
        delegate?.modelDidUpdate()
        
        Firebase<Bookshelf>.save(item: bookshelf) { success in
            guard success else { return }
            DispatchQueue.main.async {
                completion()
            }
        }
    }
    
    func delete(at indexPath: IndexPath, completion: @escaping () -> Void ) {
        let bookshelf = bookshelves[indexPath.row]
        bookshelves.remove(at: indexPath.row)
        
        Firebase<Bookshelf>.delete(item: bookshelf) { success in
            guard success else { return }
            DispatchQueue.main.async {
                completion()
            }
        }
    }
    
    func update(bookshelf: Bookshelf, completion: @escaping () -> Void ) {
        
        Firebase<Bookshelf>.save(item: bookshelf) { success in
            guard success else { return }
            DispatchQueue.main.async {
                completion()
            }
        }
    }
 
    
    
}
