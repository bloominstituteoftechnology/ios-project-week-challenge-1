import UIKit

protocol BooksListBusinessLogic {
    var searchWord:String? { get set }
    func doGetBooks(request: BooksList.GetBooks.Request)
    func doGetBooksOrderBy(request: BooksList.GetBooks.Request)
    func doGetNextBooks(request: BooksList.GetBooks.Request)
    func doGetSameBooks(request: BooksList.GetBooks.Request)
    func doRouteToBookDetails(request: BooksList.BookDetails.Request)
}

protocol BooksListDataStore {
    var bookModel: BookModel! { get set }
}

class BooksListInteractor: BooksListBusinessLogic, BooksListDataStore {
    var searchWord: String?
    var presenter: BooksListPresentationLogic?
    var worker: BooksListWorker?
    var bookModel: BookModel!
    var delegate: BooksListDataStore?
    var booksListViewController: BooksListViewController?
    
    // MARK: - Logic Properties
    var startIndex: Int = 0
    var orderBy = BookQuery.OrderBy.relevance
    
    // MARK: - Business logic
    func doGetBooks(request: BooksList.GetBooks.Request) {
        Manager.api.book.get(bookQuery: getBookQuery()!) { [weak self] result in
            let response = BooksList.GetBooks.Response(result: result)
            self?.presenter?.presentGetBooks(response: response)
        }
    }
    
    func doGetBooksOrderBy(request: BooksList.GetBooks.Request) {
        startIndex = 0
        orderBy = (orderBy == .relevance ? .newest : .relevance)
        Manager.api.book.get(bookQuery: getBookQuery()!) { [weak self] result in
            let response = BooksList.GetBooks.Response(result: result)
            self?.presenter?.presentGetBooksOrderBy(response: response)
        }
    }
    
    func doGetNextBooks(request: BooksList.GetBooks.Request) {
        startIndex += 1
        doGetBooks(request: request)
    }
    
    func doGetSameBooks(request: BooksList.GetBooks.Request) {
        doGetBooks(request: request)
    }
    
    func doRouteToBookDetails(request: BooksList.BookDetails.Request) {
        self.bookModel = request.bookModel
        presenter?.presentRouteToBookDetails()
    }
    
    private func getBookQuery() -> BookQuery? {
        guard let searchWord = searchWord else { NSLog("ERROR Unable to unwrap search word"); return nil }
        return BookQuery(searchText: searchWord,
                         startIndex: startIndex,
                         maxResults: 40,
                         filter: .paidEbooks,
                         orderBy: orderBy)
    }
}
