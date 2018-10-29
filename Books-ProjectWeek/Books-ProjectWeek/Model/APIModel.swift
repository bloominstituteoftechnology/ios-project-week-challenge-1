import Foundation

protocol API {
    func search(query: String, completion: @escaping (SearchResults?, Error?) -> Void) -> Void
}

class FakeAPI: API {
    func search(query: String, completion: @escaping (SearchResults?, Error?) -> Void) -> Void {
        completion(SearchResults(items:[Volume(id: "blah", info: VolumeInfo(title: "blah", authors: ["fooo"], publisher: "blah", publishedDate: "blaaah", description: "blahaa", industryIdentifiers: [IndustryIdentifier(type: "blaaah", identifier: "blahhh")], pageCount: 4, printType: "bbbbbbbb", categories: ["Novel"], averageRating: 4.3, ratingsCount: 5, maturityRating: "blaaah", imageLinks:ImageLinks(smallThumbnail: "blaaah", thumbnail: "blaaah"), language: "English", previewLink: "gggggggg", infoLink: "bbbbbbbbb", canonicalVolumeLink: "eeeeeeee")
            )
            ]
        ), nil)
        
        
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

