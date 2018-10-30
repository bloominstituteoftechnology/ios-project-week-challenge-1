import UIKit

enum BooksList {
    // MARK: - Use cases
    enum GetBooks {
        struct Request { }
        struct Response {
            var result: Result<[BookModel]>
        }
        struct ViewModel {
            var result: Result<BookSectionModel>
        }
    }
    enum BookDetails {
        struct Request {
            var bookModel: BookModel
        }
        struct Response { }
        struct ViewModel { }
    }
}
