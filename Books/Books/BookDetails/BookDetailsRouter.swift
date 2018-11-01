import UIKit

@objc protocol BookDetailsRoutingLogic {
    // func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol BookDetailsDataPassing {
    var dataStore: BookDetailsDataStore? { get set }
}

class BookDetailsRouter: NSObject, BookDetailsRoutingLogic, BookDetailsDataPassing {
    
    weak var viewController: BookDetailsViewController?
    var dataStore: BookDetailsDataStore?
    
    // MARK: Routing
    // func routeToSomewhere(segue: UIStoryboardSegue?) {
    //     if let segue = segue {
    //         let destinationVC = segue.destination as! SomewhereViewController
    //         var destinationDS = destinationVC.router!.dataStore!
    //         passDataToSomewhere(source: dataStore!, destination: &destinationDS)
    //     } else {
    //         let storyboard = UIStoryboard(name: "Main", bundle: nil)
    //         let destinationVC = storyboard.instantiateViewController(withIdentifier: "SomewhereViewController") as! SomewhereViewController
    //        var destinationDS = destinationVC.router!.dataStore!
    //         passDataToSomewhere(source: dataStore!, destination: &destinationDS)
    //         navigateToSomewhere(source: viewController!, destination: destinationVC)
    //     }
    // }
    
    // MARK: Navigation
    // func navigateToSomewhere(source: BookDetailsViewController, destination: SomewhereViewController) {
    //     source.show(destination, sender: nil)
    // }
    
    // MARK: Passing data
    // func passDataToSomewhere(source: BookDetailsDataStore, destination: inout SomewhereDataStore) {
    //     destination.name = source.name
    // }
}
