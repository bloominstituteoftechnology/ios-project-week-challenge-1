import UIKit

protocol BooksListPresentationLogic {
    func presentGetBooks(response: BooksList.GetBooks.Response)
    func presentGetBooksOrderBy(response: BooksList.GetBooks.Response)
    func presentRouteToBookDetails()
}

class BooksListPresenter: BooksListPresentationLogic {
    
    weak var viewController: BooksListDisplayLogic?
    
    // MARK: - Presentation logic
    func presentGetBooks(response: BooksList.GetBooks.Response) {
        switch response.result {
        case .success(let bookModels):
            Manager.log.info("Get books succeeded.")
            let bookSectionModel = BookSectionModel(bookModels: bookModels)
            let result = Result<BookSectionModel>.success(value: bookSectionModel)
            let viewModel = BooksList.GetBooks.ViewModel(result: result)
            viewController?.displayGetBooksSuccess(viewModel: viewModel)
        case .failure(_):
            Manager.log.error("Get books has failed.")
            let alertModel = AlertError.AlertInfo(title: "Ops!",
                                                  message: "Something went wrong",
                                                  defaultButtonTitle: "Retry",
                                                  dismissButtonTitle: "Dismiss")
            let alertError = AlertError.alertInfo(alertModel)
            let result = Result<BookSectionModel>.failure(error: alertError)
            let viewModel = BooksList.GetBooks.ViewModel(result: result)
            viewController?.displayGetBooksError(viewModel: viewModel)
        }
    }
    
    func presentGetBooksOrderBy(response: BooksList.GetBooks.Response) {
        switch response.result {
        case .success(let bookModels):
            Manager.log.info("Get books succeeded.")
            let bookSectionModel = BookSectionModel(bookModels: bookModels)
            let result = Result<BookSectionModel>.success(value: bookSectionModel)
            let viewModel = BooksList.GetBooks.ViewModel(result: result)
            viewController?.displayGetBooksOrderBySuccess(viewModel: viewModel)
        case .failure(_):
            Manager.log.error("Get books has failed.")
            let alertModel = AlertError.AlertInfo(title: "Ops!",
                                                  message: "Something went wrong",
                                                  defaultButtonTitle: "Retry",
                                                  dismissButtonTitle: "Dismiss")
            let alertError = AlertError.alertInfo(alertModel)
            let result = Result<BookSectionModel>.failure(error: alertError)
            let viewModel = BooksList.GetBooks.ViewModel(result: result)
            viewController?.displayGetBooksError(viewModel: viewModel)
        }
    }
    
    func presentRouteToBookDetails() {
        viewController?.displayRouteToBookDetails()
    }
}
