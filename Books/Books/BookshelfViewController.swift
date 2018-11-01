//
//  BookshelfViewController.swift
//  Books
//
//  Created by Sean Hendrix on 10/31/18.
//  Copyright © 2018 Sean Hendrix. All rights reserved.
//

import UIKit
import Anchorage
import Kingfisher


class BookshelfViewController: UIViewController {
    
    private var titleLabel = UILabel()
    private var subtitleLabel = UILabel()
    private var authorsLabel = UITextField(frame: CGRect(x: 20, y: 100, width: 300, height: 40))
    private var averageRatingLabel = UIButton()
    //private var headerView = UIView()
    //var delegate = BookshelfViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Bookshelf"
        setupComponents()
        setupConstraints()
    }
    
    private func setupComponents() {
        view.backgroundColor = .white
        
        titleLabel.text = "Do Not Open This Math Book:"
        subtitleLabel.text = "Create Bookshelf"
        //authorsLabel.text = "Extra Label"
        averageRatingLabel.setTitle("Create", for: .normal)
        
        // navigation
        let leftButton = UIBarButtonItem(title: "Back",
                                         style: .plain,
                                         target: self,
                                         action: #selector(leftNavigationButtonDidTapped))
        navigationItem.leftBarButtonItem = leftButton
        
        let rightButton = UIBarButtonItem(title: "Favorites",
                                          style: .plain,
                                          target: self,
                                          action: #selector(rightNavigationButtonDidTapped))
        navigationItem.rightBarButtonItem = rightButton

        // titleLabel
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.textColor = .black
        titleLabel.textAlignment = .center
        view.addSubview(titleLabel)
        
        // subtitleLabel
        subtitleLabel.font = UIFont.systemFont(ofSize: 20)
        subtitleLabel.textColor = .black
        //subtitleLabel.placeholder = ""
        view.addSubview(subtitleLabel)
        
        // authorsLabel
        authorsLabel.font = UIFont.italicSystemFont(ofSize: 17)
        authorsLabel.textColor = .gray
        authorsLabel.placeholder = "Bookshelf name"
        //authorsLabel.delegate = self
        view.addSubview(authorsLabel)
        
        // averageRatingLabel
        averageRatingLabel.backgroundColor = .blue
        averageRatingLabel.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        view.addSubview(averageRatingLabel)
    }
    
    @objc func buttonAction(sender: UIButton!) {
        print("button tapped")
    }
    
    func backAction() -> Void {
        self.navigationController?.popViewController(animated: true)
    }
    
    var viewController = FavoritesViewController()
    
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
        titleLabel.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.5).isActive = true
        
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
