import UIKit
import IGListKit
import Anchorage

protocol BooksListDisplayLogic: class {
    func displayGetBooksSuccess(viewModel: BooksList.GetBooks.ViewModel)
    func displayGetBooksError(viewModel: BooksList.GetBooks.ViewModel)
    func displayGetBooksOrderBySuccess(viewModel: BooksList.GetBooks.ViewModel)
    func displayRouteToBookDetails()
}

class BooksListViewController: UIViewController, BooksListDisplayLogic {
    
    var interactor: BooksListBusinessLogic?
    var router: (NSObjectProtocol & BooksListRoutingLogic & BooksListDataPassing)?
    let searchController = UISearchController(searchResultsController: nil)
    var filteredBooks = [BookModel]()
    var books = [BookModel]()
    var bookModel: BookModel?
    var searchText: BooksListInteractor! 
    
    // MARK: - UI Properties
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    lazy fileprivate var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self, workingRangeSize: 2)
    }()
    private let loaderView = LoaderView()
    
    // MARK: - Logic Properties
    fileprivate var sectionObjects = [ListDiffable]()
    fileprivate var bookSectionModel: BookSectionModel!
    fileprivate var previousBookSectionModel: BookSectionModel?
    fileprivate let spinnerSection = SpinnerSection()
    fileprivate var canLoadNextPage = true
    fileprivate var isLoadingNextPage = false
    
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
    override func viewDidLoad() {
        super.viewDidLoad()
        // Setup the Search Controller
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Books"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        searchController.delegate = self
        doGetBooks()
    }
    
    // MARK: - Private instance methods
    
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredBooks = books.filter({( bookModel : BookModel) -> Bool in
            return bookModel.title!.lowercased().contains(searchText.lowercased())
        })
        //BooksListViewController.reloadData()
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
    
    // MARK: - Setup
    private func setup() {
        let viewController = self
        let interactor = BooksListInteractor()
        let presenter = BooksListPresenter()
        let router = BooksListRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    private func setupComponents() {
        // self
        title = "Books"
        view.backgroundColor = UIColor.white
        
        // navigation
        let leftButton = UIBarButtonItem(title: "Newest",
                                         style: .plain,
                                         target: self,
                                         action: #selector(leftNavigationButtonDidTapped))
        navigationItem.leftBarButtonItem = leftButton
        
        let rightButton = UIBarButtonItem(title: "Top Rated",
                                          style: .plain,
                                          target: self,
                                          action: #selector(rightNavigationButtonDidTapped))
        navigationItem.rightBarButtonItem = rightButton
        
        // adapter
        adapter.dataSource = self
        adapter.scrollViewDelegate = self
        adapter.collectionView = collectionView
        
        // collectionView
        collectionView.backgroundColor = UIColor.white
        collectionView.bounces = false
        view.addSubview(collectionView)
    }
    
    private func setupConstraints() {
        // collectionView
        collectionView.edgeAnchors == view.edgeAnchors
    }
    
    // MARK: - Private methods
    @objc private func leftNavigationButtonDidTapped() {
        loaderView.showInView(view: view)
        let request = BooksList.GetBooks.Request()
        interactor?.doGetBooksOrderBy(request: request)
    }
    
    @objc private func rightNavigationButtonDidTapped() {
        if navigationItem.rightBarButtonItem?.title == "Top Rated" {
            let filtered = bookSectionModel.bookModels.filter { model in
                guard let averageRating = model.averageRating else { return false }
                return averageRating >= 4.0
            }
            guard filtered.count > 0 else {
                let dismissAction = UIAlertAction(title: "Dismiss",
                                                  style: .default,
                                                  handler: nil)
                
                let alertController = UIAlertController(title: "Ops!",
                                                        message: "Seems that in this book list there is no book with a top rate.",
                                                        preferredStyle: .alert)
                alertController.addAction(dismissAction)
                present(alertController, animated: true)
                return
            }
            let sorted = filtered.sorted(by: { $0.averageRating! > $1.averageRating! })
            previousBookSectionModel = bookSectionModel.copy() as? BookSectionModel
            bookSectionModel.bookModels = sorted
            navigationItem.rightBarButtonItem?.title = "All"
        } else {
            guard let bookModels = previousBookSectionModel?.bookModels else { return }
            bookSectionModel.bookModels = bookModels
            previousBookSectionModel = nil
            navigationItem.rightBarButtonItem?.title = "Top Rated"
        }
        adapter.reloadData { (completed) in
            self.adapter.scroll(to: self.bookSectionModel,
                                supplementaryKinds: nil,
                                scrollDirection: .vertical,
                                scrollPosition: .top,
                                animated: false)
        }
    }
    
    private func doGetBooks() {
        loaderView.showInView(view: view)
        let request = BooksList.GetBooks.Request()
        interactor?.doGetBooks(request: request)
    }
    
    fileprivate func doGetNextBooks() {
        let request = BooksList.GetBooks.Request()
        interactor?.doGetNextBooks(request: request)
    }
    
    fileprivate func doGetSameBooks() {
        loaderView.showInView(view: view)
        let request = BooksList.GetBooks.Request()
        interactor?.doGetSameBooks(request: request)
    }
    
    // MARK: - Display logic
    func displayGetBooksSuccess(viewModel: BooksList.GetBooks.ViewModel) {
        if !isLoadingNextPage { loaderView.removeFromSuperview() }
        guard let bookSectionModel = viewModel.result.value else { return }
        guard sectionObjects.count > 0 else {
            self.bookSectionModel = bookSectionModel
            sectionObjects.append(self.bookSectionModel)
            adapter.performUpdates(animated: true, completion: nil)
            return
        }
        guard bookSectionModel.bookModels.count > 0 else {
            canLoadNextPage = false
            isLoadingNextPage = false
            adapter.performUpdates(animated: true, completion: nil)
            return
        }
        if isLoadingNextPage {
            isLoadingNextPage = false
            adapter.performUpdates(animated: true, completion: nil)
        }
        guard let sectionController = adapter.sectionController(forSection: 0) as? BookSectionController else { return }
        sectionController.collectionContext?.performBatch(animated: true,
                                                          updates: { batchContext in
                                                            let previousCount = sectionController.bookSectionModel.bookModels.count
                                                            let startIndex = previousCount == 0 ? 0 : previousCount
                                                            let endIndex = previousCount + bookSectionModel.bookModels.count - 1
                                                            sectionController.bookSectionModel.bookModels.append(contentsOf: bookSectionModel.bookModels)
                                                            batchContext.insert(in: sectionController, at: IndexSet(startIndex...endIndex))
        },
                                                          completion: nil)
    }
    
    func displayGetBooksOrderBySuccess(viewModel: BooksList.GetBooks.ViewModel) {
        loaderView.removeFromSuperview()
        guard let bookSectionModel = viewModel.result.value else { return }
        sectionObjects.removeAll()
        self.bookSectionModel = bookSectionModel
        sectionObjects.append(self.bookSectionModel)
        adapter.reloadData()
        navigationItem.leftBarButtonItem?.title = (navigationItem.leftBarButtonItem?.title == "Newest" ? "Relevance" : "Newest")
        // reset Top Rated filter
        previousBookSectionModel = nil
        navigationItem.rightBarButtonItem?.title = "Top Rated"
    }
    
    func displayGetBooksError(viewModel: BooksList.GetBooks.ViewModel) {
        loaderView.removeFromSuperview()
        guard let alertError = viewModel.result.error as? AlertError, case .alertInfo(let alertInfo) = alertError else { return }
        let retryAction = UIAlertAction(title: alertInfo.defaultButtonTitle,
                                        style: .default) { action in
                                            self.doGetSameBooks()
        }
        let dismissAction = UIAlertAction(title: alertInfo.dismissButtonTitle,
                                          style: .default,
                                          handler: nil)
        
        let alertController = UIAlertController(title: alertInfo.title,
                                                message: alertInfo.message,
                                                preferredStyle: .alert)
        alertController.addAction(retryAction)
        alertController.addAction(dismissAction)
        present(alertController, animated: true)
    }
    
    func displayRouteToBookDetails() {
        router?.routeToBookDetails()
    }
}

// MARK: - ListAdapterDataSource
extension BooksListViewController: ListAdapterDataSource {
    
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        if isLoadingNextPage {
            sectionObjects.append(spinnerSection)
        } else {
            if sectionObjects.last is SpinnerSection {
                sectionObjects.removeLast()
            }
        }
        return sectionObjects
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        if object is BookSectionModel {
            let sectionController = BookSectionController()
            sectionController.delegate = self
            return sectionController
        } else {
            return spinnerSectionController()
        }
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? { return nil }
}

// MARK: - UIScrollViewDelegate
extension BooksListViewController: UIScrollViewDelegate {
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView,
                                   withVelocity velocity: CGPoint,
                                   targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        guard navigationItem.rightBarButtonItem?.title == "Top Rated" else { return }
        let distance = scrollView.contentSize.height - (targetContentOffset.pointee.y + scrollView.bounds.height)
        guard canLoadNextPage && !isLoadingNextPage && distance < 200 else { return }
        isLoadingNextPage = true
        adapter.performUpdates(animated: true, completion: nil)
        doGetNextBooks()
    }
}

// MARK: - LeaderboardSectionControllerDelegate
extension BooksListViewController: BookSectionControllerDelegate {
    
    func didSelect(bookModel: BookModel, at index: Int) {
        let request = BooksList.BookDetails.Request(bookModel: bookModel)
        interactor?.doRouteToBookDetails(request: request)
    }
}

extension BooksListViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}

extension BooksListViewController: UISearchControllerDelegate {

}

