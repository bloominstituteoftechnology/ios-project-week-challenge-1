import UIKit

protocol BookDetailsBusinessLogic {
    func doGetBook(request: BookDetails.GetBook.Request)
}

protocol BookDetailsDataStore {
    var bookModel: BookModel! { get set }
}

class BookDetailsInteractor: BookDetailsBusinessLogic, BookDetailsDataStore {
    var searchWord: String?
    var presenter: BookDetailsPresentationLogic?
    var worker: BookDetailsWorker?
    var bookModel: BookModel!
    
    // MARK: - Logic Properties
    var startIndex: Int = 0
    var orderBy = BookQuery.OrderBy.relevance
    
    // MARK: - Business logic
    func doGetBook(request: BookDetails.GetBook.Request) {
//        worker = BookDetailsWorker()
//        worker?.doSomeWork()
        Manager.api.book.get(bookQuery: getBookQuery()!) { [weak self] result in
        let response = BookDetails.GetBook.Response(result: result)
            self?.presenter?.presentGetBook(response: response)
        }
    }
    
    
    // route to bookshelves//
//    func doRouteToBookShelves(request: BooksList.BookDetails.Request) {
//        self.bookModel = request.bookModel
//        presenter?.presentRouteToBookDetails()
//    }
    
    private func getBookQuery() -> BookQuery? {
        guard let searchWord = searchWord else { NSLog("ERROR Unable to unwrap search word"); return nil }
        return BookQuery(searchText: "test",
                         startIndex: startIndex,
                         maxResults: 1,
                         filter: .paidEbooks,
                         orderBy: orderBy)
    }
}
