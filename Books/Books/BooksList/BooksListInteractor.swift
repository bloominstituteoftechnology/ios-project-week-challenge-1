import UIKit

protocol BooksListBusinessLogic {
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
    
    var presenter: BooksListPresentationLogic?
    var worker: BooksListWorker?
    var bookModel: BookModel!
    var delegate: UISearchResultsUpdating?
    var searchText = "iOS"
    var bookListViewController: BooksListViewController?
    
    // MARK: - Logic Properties
    var startIndex: Int = 0
    var orderBy = BookQuery.OrderBy.relevance
    
    // MARK: - Business logic
    func doGetBooks(request: BooksList.GetBooks.Request) {
        Manager.api.book.get(bookQuery: getBookQuery()) { [weak self] result in
            let response = BooksList.GetBooks.Response(result: result)
            self?.presenter?.presentGetBooks(response: response)
        }
    }
    
    func doGetBooksOrderBy(request: BooksList.GetBooks.Request) {
        startIndex = 0
        orderBy = (orderBy == .relevance ? .newest : .relevance)
        Manager.api.book.get(bookQuery: getBookQuery()) { [weak self] result in
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
    
    private func getBookQuery() -> BookQuery {
        return BookQuery(searchText: "\(searchText)",
                         startIndex: startIndex,
                         maxResults: 40,
                         filter: .paidEbooks,
                         orderBy: orderBy)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
    
}
