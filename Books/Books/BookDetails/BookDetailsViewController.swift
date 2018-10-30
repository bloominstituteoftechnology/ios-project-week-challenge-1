import UIKit

protocol BookDetailsDisplayLogic: class {
    func displaySomething(viewModel: BookDetails.Something.ViewModel)
}

class BookDetailsViewController: UIViewController, BookDetailsDisplayLogic {
    
    var interactor: BookDetailsBusinessLogic?
    var router: (NSObjectProtocol & BookDetailsRoutingLogic & BookDetailsDataPassing)?
    
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
    
    // MARK: - View lifecycle
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        let dismissAction = UIAlertAction(title: "Dismiss",
//                                          style: .default,
//                                          handler: nil)
//
//        let alertController = UIAlertController(title: "Ops!",
//                                                message: "Working in progress :)",
//                                                preferredStyle: .alert)
//        alertController.addAction(dismissAction)
//        present(alertController, animated: true)
        
    }
    
    // MARK: - Setup
    private func setup() {
        let viewController = self
        let interactor = BookDetailsInteractor()
        let presenter = BookDetailsPresenter()
        let router = BookDetailsRouter()
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
    }
    
    private func setupConstraints() {
        
    }
    
    // MARK: - Private methods
    private func doSomething() {
        let request = BookDetails.Something.Request()
        interactor?.doSomething(request: request)
    }
    
    // MARK: - Display logic
    func displaySomething(viewModel: BookDetails.Something.ViewModel) {
        
    }
}
