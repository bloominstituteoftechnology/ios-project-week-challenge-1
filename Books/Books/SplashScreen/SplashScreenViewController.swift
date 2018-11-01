import UIKit
import Anchorage

protocol SplashScreenDisplayLogic: class {
    func displayLoadManagersSuccess()
    func displayLoadManagersError(viewModel: SplashScreen.Manager.ViewModel)
}

class SplashScreenViewController: UIViewController, SplashScreenDisplayLogic {
    
    var interactor: SplashScreenBusinessLogic?
    var router: (NSObjectProtocol & SplashScreenRoutingLogic & SplashScreenDataPassing)?
    
    // MARK: - UI Properties
    private let activityIndicatorView = UIActivityIndicatorView(style: .gray)
    
    // MARK: - Object lifecycle
    convenience init() {
        self.init(nibName: nil, bundle: nil)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
        setupComponents()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
        setupComponents()
        setupConstraints()
    }
    
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//    }
    
    // MARK: - View lifecycle
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        doLoadManagers()
    }
    
    // MARK: - Setup
    private func setup() {
        let viewController = self
        let interactor = SplashScreenInteractor()
        let presenter = SplashScreenPresenter()
        let router = SplashScreenRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    private func setupComponents() {
        // self
        view.backgroundColor = UIColor.white
        
        // activityIndicatorView
        view.addSubview(activityIndicatorView)
    }
    
    private func setupConstraints() {
        // activityIndicatorView
        activityIndicatorView.centerXAnchor == view.centerXAnchor
        activityIndicatorView.centerYAnchor == view.centerYAnchor
    }
    
    // MARK: - Private methods
    func doLoadManagers() {
        activityIndicatorView.startAnimating()
        interactor?.doLoadManagers()
    }
    
    // MARK: - Display logic
    func displayLoadManagersSuccess() {
        activityIndicatorView.stopAnimating()
        router?.routeToBooksList()
    }
    
    func displayLoadManagersError(viewModel: SplashScreen.Manager.ViewModel) {
        activityIndicatorView.stopAnimating()
        guard let alertError = viewModel.result.error as? AlertError, case .alertInfo(let alertInfo) = alertError else { return }
        let closeAction = UIAlertAction(title: alertInfo.defaultButtonTitle,
                                        style: .default) { action in
                                            exit(0)
        }
        let alertController = UIAlertController(title: alertInfo.title,
                                                message: alertInfo.message,
                                                preferredStyle: .alert)
        alertController.addAction(closeAction)
        present(alertController, animated: true)
    }
}
