import Foundation


class Book: Codable {
    let name: String
    let image: String?
    var review: String
    var read: Bool
    
    var identifier: UUID
    
    var bookshelves: [String] = []
    
    init(name: String, image: String, review: String = "", read: Bool = false, identifier: UUID = UUID()) {
        (self.name, self.image, self.review, self.read, self.identifier) = (name, image, review, read, identifier)
    }
}


struct BookStub: Codable {
    let name: String
    let image: String?
    var review: String
    var read: Bool
    
    var identifier: String
    
    var bookshelves: [String] = []
    
    init(name: String, image: String, review: String, read: Bool, bookshelves: [String], identifier: String) {
        (self.name, self.image, self.review, self.read, self.bookshelves, self.identifier) = (name, image, review, read, bookshelves, identifier)
    }
}
