import UIKit

@objc protocol BooksListRoutingLogic {
    func routeToBookDetails()
}

protocol BooksListDataPassing {
    var dataStore: BooksListDataStore? { get set }
}

class BooksListRouter: NSObject, BooksListRoutingLogic, BooksListDataPassing {
    
    weak var viewController: BooksListViewController?
    var dataStore: BooksListDataStore?
    
    // MARK: Routing
    func routeToBookDetails() {
        let destinationVC = BookDetailsViewController()
        var destinationDS = destinationVC.router!.dataStore!
        passDataToBookDetails(source: dataStore!, destination: &destinationDS)
        navigateToBookDetails(source: viewController!, destination: destinationVC)
    }
    
    // MARK: Navigation
    func navigateToBookDetails(source: BooksListViewController, destination: BookDetailsViewController) {
        source.navigationController?.pushViewController(destination, animated: true)
    }
    
    // MARK: Passing data
    func passDataToBookDetails(source: BooksListDataStore, destination: inout BookDetailsDataStore) {
        destination.bookModel = source.bookModel
    }
}
