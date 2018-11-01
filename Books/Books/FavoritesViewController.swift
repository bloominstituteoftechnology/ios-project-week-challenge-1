
import UIKit
import Anchorage
import Kingfisher


class FavoritesViewController: UIViewController {
    
//    var headerView = UIView!
    var book: Book?
    
    private var titleLabel = UILabel()
    private var subtitleLabel = UILabel()
    private var authorsLabel = UITextField(frame: CGRect(x: 20, y: 100, width: 300, height: 100))
    private var averageRatingLabel = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Review"
        setupComponents()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        authorsLabel.text = book?.review
    }
    
    private func setupComponents() {
        view.backgroundColor = .white
        
        titleLabel.text = "Do Not Open This Math Book:"
        subtitleLabel.text = "Write review"
        averageRatingLabel.setTitle("Save", for: .normal)
        
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
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        view.addSubview(titleLabel)
        
        // subtitleLabel
        subtitleLabel.font = UIFont.systemFont(ofSize: 17)
        subtitleLabel.textColor = .black
        view.addSubview(subtitleLabel)
        
        // authorsLabel
        authorsLabel.font = UIFont.italicSystemFont(ofSize: 17)
        authorsLabel.textColor = .black
        //authorsLabel.backgroundColor = .red
        authorsLabel.placeholder = "write something"
        view.addSubview(authorsLabel)
        
        // averageRatingLabel
        averageRatingLabel.backgroundColor = .blue
        averageRatingLabel.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        view.addSubview(averageRatingLabel)
    }
    
    @objc func buttonAction(sender: UIButton!) {
        if let text = authorsLabel.text {
            book?.review = text
        }
        navigationController?.popViewController(animated: true)
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
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        titleLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.4).isActive = true
        titleLabel.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.3).isActive = true
        
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

