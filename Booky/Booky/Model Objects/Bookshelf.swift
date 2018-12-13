import Foundation

class Bookshelf: Codable, FirebaseItem {
    var name: String
    var uuid = UUID().uuidString
    var recordIdentifier = ""
    var books: [Book] = []
    let volumeInfo: VolumeInfo
    
    enum CodingKeys: String, CodingKey {
        case volumeInfo = "volumeInfo"
        case name = "name"
        case books = "books"
    }
    
    struct VolumeInfo: Codable {
        let title: String
        let subtitle: String?
        let imageLinks: ImageLinks?
        let authors: [String]?
        let publisher: String?
    }

    struct ImageLinks: Codable {
        let thumbnail: String
    }

    init(name: String, books: [Book], volumeInfo: VolumeInfo) {
        self.name = name
        self.books = books
        self.volumeInfo = volumeInfo
    }
}




