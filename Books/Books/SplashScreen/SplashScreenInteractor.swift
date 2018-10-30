import UIKit

protocol SplashScreenBusinessLogic {
    func doLoadManagers()
}

protocol SplashScreenDataStore { }

class SplashScreenInteractor: SplashScreenBusinessLogic, SplashScreenDataStore {
    
    var presenter: SplashScreenPresentationLogic?
    var worker: SplashScreenWorker?
    
    // MARK: - Business logic
    func doLoadManagers() {
        Manager.startupManagers { [weak self] result in
            let response = SplashScreen.Manager.Response(result: result)
            self?.presenter?.presentLoadManagers(response: response)
        }
    }
}
