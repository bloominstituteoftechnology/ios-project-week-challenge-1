import Foundation

protocol API {
    func search(query: String, completion: @escaping (SearchResults?, Error?) -> Void) throws -> Void
}

class FakeAPI: API {
    func search(query: String, completion: @escaping (SearchResults?, Error?) -> Void) throws -> Void {
        completion(SearchResults(items: []), nil)
    }
    
   
    
}

struct SearchResults: Codable {
    let items: [Volume]
}

struct Volume: Codable {
    let id: String
    let info: VolumeInfo
}

struct VolumeInfo: Codable {
    let title: String
    let authors: [String]
    let publisher, publishedDate, description: String
    let industryIdentifiers: [IndustryIdentifier]
    let pageCount: Int
    let printType: String
    let categories: [String]
    let averageRating: Double
    let ratingsCount: Int
    let maturityRating: String
    let imageLinks: ImageLinks
    let language: String
    let previewLink: String
    let infoLink, canonicalVolumeLink: String
}

struct ImageLinks: Codable {
    let smallThumbnail, thumbnail: String
}

struct IndustryIdentifier: Codable {
    let type, identifier: String
}

