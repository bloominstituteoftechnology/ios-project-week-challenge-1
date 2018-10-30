import Foundation

class Bookshelf {
    let name: String
    var books: [Book] = []
    
    init(name: String, books: [Book]) {
        self.name = name
        self.books = books
    }
}
