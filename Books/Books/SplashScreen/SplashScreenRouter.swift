import UIKit

@objc protocol SplashScreenRoutingLogic {
    func routeToBooksList()
}

protocol SplashScreenDataPassing {
    var dataStore: SplashScreenDataStore? { get set }
}

class SplashScreenRouter: NSObject, SplashScreenRoutingLogic, SplashScreenDataPassing {
    
    weak var viewController: SplashScreenViewController?
    var dataStore: SplashScreenDataStore?
    
    // MARK: Routing
    func routeToBooksList() {
        let destinationVC = BooksListViewController()
        navigateToBooksList(source: viewController!, destination: destinationVC)
    }
    
    // MARK: Navigation
    func navigateToBooksList(source: SplashScreenViewController, destination: BooksListViewController) {
        Manager.navigation.setRootWithNavigation(viewControllers: [destination])
    }
}
