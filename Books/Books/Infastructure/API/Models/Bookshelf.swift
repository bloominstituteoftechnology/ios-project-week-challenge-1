import Foundation


class Bookshelf {
    let name: String
    var books: [BookModel] = []
    
    init(name: String, books: [BookModel]) {
        (self.name, self.books) = (name, books)
    }
}
