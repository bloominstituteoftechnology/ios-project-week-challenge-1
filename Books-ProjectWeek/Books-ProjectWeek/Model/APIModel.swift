import Foundation
import UIKit

var searchVolume: SearchTableViewController?

protocol API {
    func search(query: String, completion: @escaping (SearchResults?, Error?) -> Void) -> Void
}

//class FakeAPI: API {
//    func search(query: String, completion: @escaping (SearchResults?, Error?) -> Void) -> Void {
//        completion(SearchResults(items:[Volume(id: "blah", info: VolumeInfo(title: "blah", authors: ["fooo"], publisher: "blah", publishedDate: "blaaah", description: "blahaa", industryIdentifiers: [IndustryIdentifier(type: "blaaah", identifier: "blahhh")], pageCount: 4, printType: "bbbbbbbb", categories: ["Novel"], averageRating: 4.3, ratingsCount: 5, maturityRating: "blaaah", imageLinks:ImageLinks(smallThumbnail: "blaaah", thumbnail: "blaaah"), language: "English", previewLink: "gggggggg", infoLink: "bbbbbbbbb", canonicalVolumeLink: "eeeeeeee")
//            )
//            ]
//        ), nil)
//
//
//    }
//}


enum APIError: Error {
    case url
}

class GoogleBooksApi: API {
    static let baseURL = URL(string: "https://www.googleapis.com/books/v1/volumes")!
    func search(query: String, completion: @escaping (SearchResults?, Error?) -> Void) {
     
        var cs = URLComponents(url: GoogleBooksApi.baseURL, resolvingAgainstBaseURL: true)!
        cs.queryItems = [URLQueryItem(name: "q", value: query)]
        
        guard let url = cs.url else {
            completion(nil, APIError.url)
            return
        }
        
        Fetcher.GET(url: url, completion: completion)
    }
    
}


struct SearchResults: Codable {
    let items: [Volume]
}

struct Volume: Codable {
    let id: String
    let volumeInfo: VolumeInfo
}

struct VolumeInfo: Codable {
    let title: String
    let authors: [String]?
    let publisher: String?
    let publishedDate: String
    let description: String?
    let industryIdentifiers: [IndustryIdentifier]
    let pageCount: Int?
    let printType: String
    let categories: [String]?
    let averageRating: Double?
    let ratingsCount: Int?
    let maturityRating: String
    let imageLinks: ImageLinks
    let language: String
    let previewLink: String
    let infoLink, canonicalVolumeLink: String
}

struct ImageLinks: Codable {
    let smallThumbnail, thumbnail: String
    
    func thumbnailImage(completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: thumbnail) else {return}
        ImageLoader.fetchImage(from: url, completion: completion)
    }
    
    func smallThumbnailImage(completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: smallThumbnail) else {return}
        ImageLoader.fetchImage(from: url, completion: completion)
    }
}

struct IndustryIdentifier: Codable {
    let type, identifier: String
}

