
import UIKit
import Anchorage
import Kingfisher


class FavoritesViewController: UIViewController {
    
//    var headerView = UIView!
    
    private var titleLabel = UILabel()
    private var subtitleLabel = UILabel()
    private var authorsLabel = UILabel()
    private var averageRatingLabel = UILabel()
    private var headerView = UIView()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Favorites"
        setupComponents()
        setupConstraints()
    }
    
    private func setupComponents() {
        view.backgroundColor = .red
        
        titleLabel.text = "Title Label"   //bookModel.title
        subtitleLabel.text = "Subtitle Label"   //bookModel.subtitle
        authorsLabel.text = "Extra Label"//bookModel.authors  //fix from array of authors to author
        averageRatingLabel.text = "N/A"
        
        // navigation
        let leftButton = UIBarButtonItem(title: "Back",
                                         style: .plain,
                                         target: self,
                                         action: #selector(leftNavigationButtonDidTapped))
        navigationItem.leftBarButtonItem = leftButton
        
        let rightButton = UIBarButtonItem(title: "Search",
                                          style: .plain,
                                          target: self,
                                          action: #selector(rightNavigationButtonDidTapped))
        navigationItem.rightBarButtonItem = rightButton
        
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
    
    func backAction() -> Void {
        self.navigationController?.popViewController(animated: true)
    }
    
    var viewController = BooksListViewController()
    
    func saveAction() -> Void {
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    // MARK: - Private methods
    @objc private func leftNavigationButtonDidTapped() {
        backAction()
    }
    
    @objc private func rightNavigationButtonDidTapped() {
        saveAction()
    }
    
    private func setupConstraints() {
        
        // titleLabel
        titleLabel.topAnchor == view.topAnchor
        titleLabel.centerYAnchor == view.centerYAnchor
        titleLabel.leftAnchor == view.rightAnchor + 10.0
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
}

