import Foundation

class Bookshelf: Codable, FirebaseItem {
    var name: String
    var uuid = UUID().uuidString
    var recordIdentifier = ""
    var book: Book
    
    init(name: String, book: Book) {
        self.name = name
        self.book = book
    }
}




