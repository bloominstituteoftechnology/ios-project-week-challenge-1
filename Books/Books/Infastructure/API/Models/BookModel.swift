import Foundation

struct BookModel {
    var title: String?
    var authors: [String]?
    var subtitle: String?
    var textSnippet: String?
    var description: String?
    var averageRating: Double?
    var smallThumbnail: String?
    var thumbnail: String?
    
    init(title: String?,
         authors: [String]?,
         subtitle: String?,
         textSnippet: String?,
         description: String?,
         averageRating: Double?,
         smallThumbnail: String?,
         thumbnail: String?) {
        self.title = title
        self.authors = authors
        self.subtitle = subtitle
        self.textSnippet = textSnippet
        self.description = description
        self.averageRating = averageRating
        self.smallThumbnail = smallThumbnail
        self.thumbnail = thumbnail
    }
}

