//
//  BookController.swift
//  iOBooks
//
//  Created by Nikita Thomas on 10/29/18.
//  Copyright © 2018 Nikita Thomas. All rights reserved.
//

import UIKit

class BookController: Codable {
    static var shared = BookController()
    private init() {}
    
    var bookSearch: BookSearch?
    var bookshelves: [Bookshelf] = []
    //        didSet {
    //            uploadBooks(shelves: bookshelves)
    //        }
    
    
    func newBook(name: String, image: String, id: String) -> Book {
        return Book(name: name, image: image, review: "", read: false, id: id)
    }
    
    func newShelf(name: String, books: [Book]) -> Bookshelf{
        let shelf = Bookshelf(name: name, books: books)
        bookshelves.append(shelf)
        return shelf
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
                print("url: \(url)")
                completion()
                return
            } catch {
                NSLog("Could not decode JSON into BookSearch objects")
                completion()
                return
            }
        }
        dataTask.resume()
        
    }
    
    // MARK - FIREBASE
    
    // functions we need
    
    // download everything
    // download specefic book?
    // create a new book
    // update existing book
    
    var baseURL: URL = URL(string: "https://iobooks-76036.firebaseio.com/")!
    var bookShelfIdentifier: String = ""
    
    func createBookshelvesFromBooks(_ books:[Book]) {
        var shelves: [Bookshelf] = []
        
        for book in books {
            print("Books Bookshelves: \(book.bookshelves)")
            for shelf in book.bookshelves {
                // existing shelf
                if shelves.contains(where: { $0.name == shelf }) {
                    print("Existing shelf: \(shelf) ")
                    guard let indexPath = shelves.firstIndex(where: { $0.name == shelf }) else { fatalError( "Could not find indexPath of existing shelf" )}
                    shelves[indexPath].books.append(book)
                    print("Appending book: \(book.name) to shelf \(shelves[indexPath].name)")
                    
                    for book in shelves[indexPath].books {
                        print("Bookshelf: \(shelves[indexPath].name) has book: \(book.name)")
                    }
                    
                } else {
                    // creates a new shelf
                    print("Created New shelf: \(shelf) ")
                    let bookshelf = Bookshelf(name: shelf, books: [book])
                    shelves.append(bookshelf)
                    for book in bookshelf.books {
                        print("Bookshelf: \(bookshelf.name) has book: \(book.name)")
                    }
                }
            }
        }
        
        print(shelves.count)
        
        // Fix duplicating Bookshelves
        var sameBookShelves: [Bookshelf] = []
        var differentBookShelves: [Bookshelf] = []
        
        for shelf in shelves {
            if bookshelves.contains(where: { $0.name == shelf.name }) {
                sameBookShelves.append(shelf)
            } else {
                differentBookShelves.append(shelf)
            }
        }
        
        print("sameShelvesCount: \(sameBookShelves.count)")
        print("differentShelvesCount: \(differentBookShelves.count)")
        let emptyBookshelves = bookshelves.filter( { $0.books.isEmpty })
        print("emptyBookShelves: \(emptyBookshelves.count)")
        
        bookshelves = sameBookShelves
        bookshelves += differentBookShelves
        bookshelves += emptyBookshelves
        
        
        
        
        print("finalShelvesCount: \(bookshelves.count)")
    }
    
    func stubsToBooks(bookStubs: [String: BookStub]) -> [Book]{
        var books: [Book] = []
        for value in bookStubs.values {
            if books.contains(where: { $0.identifier == UUID(uuidString: value.identifier) }) {
                // update the already existing book
            } else {
                let book = Book(name: value.name, image: value.image ?? " ", review: value.review, read: value.read, identifier: UUID(uuidString: value.identifier)!, id: value.id)
                for shelf in value.bookshelves {
                    book.bookshelves.append(shelf)
                }
                books.append(book)
            }
            
        }
        return books
    }
    
    
    func downloadBooks(completion: @escaping (_ success: Bool) -> Void ) {
        let url = baseURL.appendingPathComponent("bookStubs").appendingPathExtension("json")
        URLSession.shared.dataTask(with: url) { data, _, err in
            if let err = err {
                NSLog("\(err)")
                completion(false)
                return
            }
            
            guard let data = data else {
                completion(false)
                return}
            
            print(url)
            
            do {
                let bookStubs = try JSONDecoder().decode([String: BookStub].self, from: data)
                
                let books = self.stubsToBooks(bookStubs: bookStubs)
                print("books: \(books)")
                // Maybe store book objects in model?
                self.createBookshelvesFromBooks(books)
                // In completion, reload tableView
                
                completion(true)
            } catch {
                completion(false)
                return
            }
            }.resume()
    }
    
    
    func bookToStub(book: Book) -> BookStub {
        
        return BookStub(name: book.name, image: book.image ?? " ", review: book.review, read: book.read, bookshelves: book.bookshelves, identifier: book.identifier.uuidString, id: book.id)
    }
    
    
    
    
    
    func uploadBook(book: Book, completion: @escaping (_ success: Bool) -> Void = { _ in }) {
        let bookStub = bookToStub(book: book)
        
        var req = URLRequest(url: baseURL.appendingPathComponent("/bookStubs").appendingPathComponent(bookStub.identifier).appendingPathExtension("json"))
        req.httpMethod = "PUT"
        
        do {
            let jsonData = try JSONEncoder().encode(bookStub)
            req.httpBody = jsonData
        } catch {
            NSLog("Couldn't encode stubs into JSON: \(error)")
            completion(false)
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: req) { data, _ , err in
            if let err = err {
                NSLog("error creating datatask: \(err)")
                completion(false)
                return
            }
            
            if let data = data, let utf8Rep = String(data: data, encoding: .utf8) {
                print("response: ", utf8Rep)
            } else {
                print("no readable data received as response")
            }
            
        }
        dataTask.resume()
    }
    
    func updateBookOnServer(book: Book, completion: @escaping (_ success: Bool) -> Void = { _ in }) {
        let bookStub = bookToStub(book: book)
        
        var req = URLRequest(url: baseURL.appendingPathComponent("/bookStubs").appendingPathComponent(bookStub.identifier).appendingPathExtension("json"))
        req.httpMethod = "PUT"
        
        do {
            let jsonData = try JSONEncoder().encode(bookStub)
            req.httpBody = jsonData
        } catch {
            NSLog("Couldn't encode stubs into JSON: \(error)")
            completion(false)
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: req) { data, _ , err in
            if let err = err {
                NSLog("error creating datatask: \(err)")
                completion(false)
                return
            }
            
            if let data = data, let utf8Rep = String(data: data, encoding: .utf8) {
                print("response: ", utf8Rep)
            } else {
                print("no readable data received as response")
            }
            
        }
        dataTask.resume()
    }
    
    
}












