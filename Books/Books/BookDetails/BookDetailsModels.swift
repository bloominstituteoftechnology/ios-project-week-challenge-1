import UIKit

enum BookDetails {
    // MARK: - Use cases
    enum GetBook {
        struct Request { }
        struct Response {
            var result: Result<[BookModel]>
        }
        struct ViewModel {
            var result: Result<[BookModel]>
        }
    
    }
}
