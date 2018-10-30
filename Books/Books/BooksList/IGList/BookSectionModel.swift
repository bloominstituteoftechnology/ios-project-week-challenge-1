import Foundation
import IGListKit

class BookSectionModel: NSObject {
    var bookModels: [BookModel]
    
    init(bookModels: [BookModel]) {
        self.bookModels = bookModels
        super.init()
    }
}

// MARK: - ListDiffable
extension BookSectionModel: ListDiffable {
    
    func diffIdentifier() -> NSObjectProtocol {
        return self
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        return isEqual(object)
    }
}

// MARK: - NSCopying
extension BookSectionModel: NSCopying {
    
    func copy(with zone: NSZone? = nil) -> Any {
        let bookSectionModel = BookSectionModel(bookModels: self.bookModels)
        return bookSectionModel
    }
}
