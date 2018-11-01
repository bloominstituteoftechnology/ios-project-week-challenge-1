import Foundation

struct BookSearch: Codable {
    var items: [Item]
}

struct Item: Codable {
    var id, etag: String
    var selfLink: String
    var volumeInfo: VolumeInfo
}

struct VolumeInfo: Codable {
    var title: String
    var authors: [String]?
    var imageLinks: ImageLinks?
}

struct ImageLinks: Codable {
    var smallThumbnail, thumbnail: String
}
