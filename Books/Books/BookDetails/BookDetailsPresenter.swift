import UIKit

protocol BookDetailsPresentationLogic {
    func presentGetBook(response: BookDetails.GetBook.Response)
}

class BookDetailsPresenter: BookDetailsPresentationLogic {
    
    weak var viewController: BookDetailsDisplayLogic?
    
    // MARK: - Presentation logic
    func presentGetBook(response: BookDetails.GetBook.Response) {
        let result = response.result
        let viewModel = BookDetails.GetBook.ViewModel(result: result)
        viewController?.displaySomething(viewModel: viewModel)
        
    }
}
