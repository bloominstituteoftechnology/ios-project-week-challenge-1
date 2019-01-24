import Foundation

struct BookResultsRepresentation: Codable {
    
    let volumeInfo: VolumeInfo
    
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
}

func == (lhs: BookResultsRepresentation, rhs: BookResults) -> Bool {
    return

        lhs.volumeInfo.title == rhs.books[0].volumeInfo.title &&
        lhs.volumeInfo.subtitle == rhs.books[0].volumeInfo.subtitle &&
        lhs.volumeInfo.authors == rhs.books[0].volumeInfo.authors &&
        lhs.volumeInfo.imageLinks?.thumbnail == rhs.books[0].volumeInfo.imageLinks?.thumbnail
}

func == (lhs: BookResults, rhs: BookResultsRepresentation) -> Bool {
    return rhs == lhs
}

func != (lhs: BookResultsRepresentation, rhs: BookResults) -> Bool {
    return !(rhs == lhs)
}

func != (lhs: BookResults, rhs: BookResultsRepresentation) -> Bool {
    return rhs != lhs
}






