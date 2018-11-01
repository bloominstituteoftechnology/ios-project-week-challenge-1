import Foundation


class Bookshelf: Codable {
    let name: String
    
    var books: [Book] = []
    
    init(name: String, books: [Book]) {
        (self.name, self.books) = (name, books)
    }
}

