import UIKit

protocol BookDetailsPresentationLogic {
    func presentSomething(response: BookDetails.Something.Response)
}

class BookDetailsPresenter: BookDetailsPresentationLogic {
    
    weak var viewController: BookDetailsDisplayLogic?
    
    // MARK: - Presentation logic
    func presentSomething(response: BookDetails.Something.Response) {
        let viewModel = BookDetails.Something.ViewModel()
        viewController?.displaySomething(viewModel: viewModel)
    }
}
