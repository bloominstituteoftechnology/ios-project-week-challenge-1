import UIKit

protocol SplashScreenPresentationLogic {
    func presentLoadManagers(response: SplashScreen.Manager.Response)
}

class SplashScreenPresenter: SplashScreenPresentationLogic {
    
    weak var viewController: SplashScreenDisplayLogic?
    
    // MARK: - Presentation logic
    func presentLoadManagers(response: SplashScreen.Manager.Response) {
        switch response.result {
        case .success:
            Manager.log.debug("Load manager succeeded.")
            viewController?.displayLoadManagersSuccess()
        case .failure(let error):
            guard let error = error as? ManagerError else { return }
            var title: String = "Ops!"
            var message: String = "Something went wrong. Please try again later."
            let defaultButtonTitle = "Close App"
            switch error {
            case .startup:
                Manager.log.error("Load manager has failed.")
                title = "Under Maintenance"
                message = "Our server is currently under maintenance. We should be back shortly. Thank you for your patience."
            }
            let alertModel = AlertError.AlertInfo(title: title,
                                                  message: message,
                                                  defaultButtonTitle: defaultButtonTitle)
            let alertError = AlertError.alertInfo(alertModel)
            let result = Result<Any>.failure(error: alertError)
            let viewModel = SplashScreen.Manager.ViewModel(result: result)
            viewController?.displayLoadManagersError(viewModel: viewModel)
        }
    }
}
