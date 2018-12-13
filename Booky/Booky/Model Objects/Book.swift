import Foundation

struct BookResults: Codable {
    var name: String?
    var tag: String?
    var uuid = UUID().uuidString
    var recordIdentifier = ""
    let books: [Book]
    
    enum CodingKeys: String, CodingKey {
        case books = "items"
    }
}

struct Book: Codable {
    let id: String
    let volumeInfo: VolumeInfo
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

//Version 2
//class Bookshelf: Codable, FirebaseItem {
//    var name: String
//    var uuid = UUID().uuidString
//    var recordIdentifier = ""
//    var books: [Book] = []
//    let volumeInfo: VolumeInfo
//
//    enum CodingKeys: String, CodingKey {
//        case volumeInfo = "volumeInfo"
//        case name = "name"
//        case books = "books"
//    }
//
//    struct VolumeInfo: Codable {
//        let title: String
//        let subtitle: String?
//        let imageLinks: ImageLinks?
//        let authors: [String]?
//        let publisher: String?
//    }
//
//    struct ImageLinks: Codable {
//        let thumbnail: String
//    }
//
//    init(name: String, books: [Book], volumeInfo: VolumeInfo) {
//        self.name = name
//        self.books = books
//        self.volumeInfo = volumeInfo
//    }
//}

// Verion 1
//class Bookshelf: Codable, Equatable, FirebaseItem {
//    
//    var name: String
//    var uuid = UUID().uuidString
//    var recordIdentifier = ""
//    let book: VolumeInfo
//    
//    enum CodingKeys: String, CodingKey {
//        case name = "name"
//        case book = "books"
//    }
//    
//    struct VolumeInfo: Codable {
//        let title: String
//        let subtitle: String?
//        let imageLinks: ImageLinks?
//        let authors: [String]?
//        let publisher: String?
//    }
//    
//    struct ImageLinks: Codable {
//        let thumbnail: String
//    }
//    
//    init(name: String, book: VolumeInfo) {
//        self.name = name
//        self.book = book
//    }
//    
//    static func == (lhs: Bookshelf, rhs: Bookshelf) -> Bool {
//        return
//            lhs.name == rhs.name &&
//                lhs.uuid == rhs.uuid
//    }
//    
//    static func != (lhs: Bookshelf, rhs: Bookshelf) -> Bool {
//        return !(rhs == lhs) && rhs != lhs
//    }
//    
//}
//
//
//
