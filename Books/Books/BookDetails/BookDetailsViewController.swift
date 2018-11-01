import UIKit
import IGListKit
import Anchorage
import Kingfisher

protocol BookDetailsDisplayLogic: class {
    func displaySomething(viewModel: BookDetails.GetBook.ViewModel)
}

class BookDetailsViewController: UIViewController, BookDetailsDisplayLogic, BookSectionControllerDelegate {
    
    weak var delegate: BookSectionControllerDelegate?
    var bookSectionModel: BookSectionModel!
    let urlKey = "https://books.google.com/books?id=ck1EDwAAQBAJ&printsec=frontcover"
    func didSelect(bookModel: BookModel, at index: Int) {
        delegate?.didSelect(bookModel: self.bookSectionModel.bookModels[index], at: index)
    }
    
    
    var interactor: BookDetailsBusinessLogic?
    var router: (NSObjectProtocol & BookDetailsRoutingLogic & BookDetailsDataPassing)?
    var headerView: UIView!
    private var imageView = UIImageView()
    private var titleLabel = UILabel()
    private var subtitleLabel = UILabel()
    private var authorsLabel = UILabel()
    private var averageRatingLabel = UILabel()
    // MARK: - Logic Properties
    private var bookModel: BookModel! {
        didSet {
            updateViews()
        }
    }
    private var position: Int!
    
    private func updateViews() {
        //guard let bookModel = bookModel, isViewLoaded else {return}
        
//        nameLabel.text = student.name
//        hometownLabel.text = student.hometown
//        hobbiesLabel.text = student.hobbies.joined(separator: ", ")
//        bioLabel.text = student.bio
    }
    
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
    
    func prepareForReuse() {
        //super.prepareForReuse()
        imageView.image = nil
        titleLabel.text = ""
        subtitleLabel.text = ""
        authorsLabel.text = ""
        averageRatingLabel.text = ""
    }
    
    // MARK: - Load UI Methods
    func loadUIObjects(bookModel: BookModel, position: Int) {
        // logic
        self.bookModel = bookModel
        self.position = position
        
        // ui
        titleLabel.text = (bookModel.title ?? "Title: N/A")
        subtitleLabel.text =  (bookModel.subtitle ?? "Subtitle: N/A")
        var authorsText: String?
        if let authors = bookModel.authors {
            authorsText = authors.joined(separator: ", ")
        }
        authorsLabel.text = "Authors: " + (authorsText ?? "N/A")
        var averageRatingText: String?
        if let averageRating = bookModel.averageRating {
            averageRatingText = String(averageRating)
        }
        averageRatingLabel.text = "Rating: " + (averageRatingText ?? "N/A")
    }
    
    func updateIsReadLabel(bookModel: BookModel) {
        self.bookModel = bookModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        setup()
//        setupComponents()
//        setupConstraints()
        
        // Initialize view and add it to the view controller's view
//        headerView = UIView()
//        headerView.backgroundColor = .red
//        self.view.addSubview(headerView)
//        // set position of view using constraints
//        headerView.translatesAutoresizingMaskIntoConstraints = false
//        headerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
//        headerView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
//        headerView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1).isActive = true
//        headerView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.15).isActive = true
        
    }
    
    // MARK: - View lifecycle
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        
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
    
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    lazy fileprivate var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self, workingRangeSize: 2)
    }()
    
    func backAction() -> Void {
        self.navigationController?.popViewController(animated: true)
    }
    
    var viewController = BookshelfViewController()
    
    func saveAction() -> Void {
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func setupComponents() {
        // self
        //title = "BookTitle"
        view.backgroundColor = .white
        
        //loadUIObjects(bookModel: bookModel, position: self)
//        guard let thumbnail = bookModel.thumbnail else { return }
        //imageView.image = bookModel.thumbnail
        
        if let url = URL(string: urlKey){
            do {
                let data = try Data(contentsOf: url)
                self.imageView.image = UIImage(data: data)
            } catch let err {
                print("Error: \(err.localizedDescription)")
            }
        }
//        imageView.kf.setImage(with: URL(string: "https://books.google.com/books?id=ck1EDwAAQBAJ&printsec=frontcover"))
        
        
        titleLabel.text = "Do Not Open This Math Book:"   //bookModel.title
        subtitleLabel.text = "Addition + Subtraction"   //bookModel.subtitle
        authorsLabel.text = "Authors: Danica McKellar"//bookModel.authors  //fix from array of authors to author
        averageRatingLabel.text = "N/A"
        
        // navigation
        let leftButton = UIBarButtonItem(title: "Back",
                                         style: .plain,
                                         target: self,
                                         action: #selector(leftNavigationButtonDidTapped))
        navigationItem.leftBarButtonItem = leftButton
        
        let rightButton = UIBarButtonItem(title: "Bookshelf",
                                          style: .plain,
                                          target: self,
                                          action: #selector(rightNavigationButtonDidTapped))
        navigationItem.rightBarButtonItem = rightButton

        // imageView
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        view.addSubview(imageView)
        
        // titleLabel
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.textColor = .black
        view.addSubview(titleLabel)
        
        // subtitleLabel
        subtitleLabel.font = UIFont.systemFont(ofSize: 17)
        subtitleLabel.textColor = .black
        view.addSubview(subtitleLabel)
        
        // authorsLabel
        authorsLabel.font = UIFont.italicSystemFont(ofSize: 17)
        authorsLabel.textColor = .gray
        view.addSubview(authorsLabel)
        
        // averageRatingLabel
        averageRatingLabel.font = UIFont.systemFont(ofSize: 15)
        averageRatingLabel.textColor = .gray
        view.addSubview(averageRatingLabel)
    }
    
    // MARK: - Private methods
    @objc private func leftNavigationButtonDidTapped() {
        backAction()
    }
    
    @objc private func rightNavigationButtonDidTapped() {
        saveAction()
    }
    
    private func setupConstraints() {
        // imageView
        imageView.leftAnchor == view.leftAnchor + 10.0
        imageView.centerYAnchor == view.centerYAnchor
        imageView.widthAnchor == 80.0
        imageView.heightAnchor == 80.0
        
        // titleLabel
        titleLabel.topAnchor == imageView.topAnchor
        titleLabel.leftAnchor == imageView.rightAnchor + 10.0
        titleLabel.rightAnchor <= view.rightAnchor - 10.0
        
        // subtitleLabel
        subtitleLabel.topAnchor == titleLabel.bottomAnchor
        subtitleLabel.leftAnchor == titleLabel.leftAnchor
        subtitleLabel.rightAnchor <= view.rightAnchor - 10.0
        
        // authorsLabel
        authorsLabel.topAnchor == subtitleLabel.bottomAnchor
        authorsLabel.leftAnchor == titleLabel.leftAnchor
        authorsLabel.rightAnchor <= view.rightAnchor - 10.0
        
        // averageRatingLabel
        averageRatingLabel.topAnchor == authorsLabel.bottomAnchor
        averageRatingLabel.leftAnchor == titleLabel.leftAnchor
        averageRatingLabel.rightAnchor <= view.rightAnchor - 10.0
    }
    
    // MARK: - Private methods
    private func doGetBook() {
        let request = BookDetails.GetBook.Request()
        interactor?.doGetBook(request: request)
    }
    
    // MARK: - Display logic
    func displaySomething(viewModel: BookDetails.GetBook.ViewModel) {
        
//        adapter.reloadData()
    }
}
