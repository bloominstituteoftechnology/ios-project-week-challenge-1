import Foundation
import SwiftyJSON

class BookParser: Parser {
    
    typealias T = [BookModel]
    
    func parse(fromJSON json: JSON) -> T {
        var books = [BookModel]()
        guard let items = json["items"].array else { return books }
        for item in items {
            books.append(BookModel(title: item["volumeInfo"]["title"].string,
                                   authors: item["volumeInfo"]["authors"].arrayObject as? [String],
                                   subtitle: item["volumeInfo"]["subtitle"].string,
                                   textSnippet: item["searchInfo"]["textSnippet"].string,
                                   description: item["volumeInfo"]["description"].string,
                                   averageRating: item["volumeInfo"]["averageRating"].double,
                                   smallThumbnail: item["volumeInfo"]["imageLinks"]["smallThumbnail"].string,
                                   thumbnail: item["volumeInfo"]["imageLinks"]["thumbnail"].string))
        }
        return books
    }
}
