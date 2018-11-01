//
//  DetailVC.swift
//  iOBooks
//
//  Created by Nikita Thomas on 10/29/18.
//  Copyright © 2018 Nikita Thomas. All rights reserved.
//

import UIKit

class DetailVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var bookTitle: UILabel!
    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var readSwitch: UISwitch!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var myReviewButton: UIButton!
    
    @IBAction func readSwitchAction(_ sender: Any) {
        switch readSwitch.isOn {
        case true:
            book?.bookshelves.append(BookController.shared.bookshelves[0].name)
            BookController.shared.bookshelves[0].books.append(book!)
            book?.read = true
        case false:
            guard let indexPath = book?.bookshelves.firstIndex(of: "Read" ) else {return}
            book?.bookshelves.remove(at: indexPath)
            
            guard let bookIndex = BookController.shared.bookshelves[0].books.firstIndex(where: { $0.name == book?.name }) else {return}
            BookController.shared.bookshelves[0].books.remove(at: bookIndex)
            
            book?.read = false
        }
        guard let book = book else {return}
        BookController.shared.updateBookOnServer(book: book)
    }
    
    @IBAction func addToNewBookshelfButton(_ sender: Any) {
        showActionSheet()
    }
    
    var book: Book?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let book = book {
            self.navigationItem.title = "\(book.name)"
        }
        tableView.delegate = self
        tableView.dataSource = self
        updateViews()
    }
    
    
    
    func updateViews() {
        bookTitle.text = book?.name
        if (book?.bookshelves.contains("Read" ))! {
            book?.read = true
        }
        
        readSwitch.setOn(book?.read ?? false, animated: false)
        if let smallImage = book?.image {
            ImageLoader.fetchImage(from: URL(string: (smallImage))) { (image) in
                guard let image = image else { return}
                DispatchQueue.main.async {
                    self.bookImage.image = image
                }
            }
        }
        
        if book?.review == "" || book?.review == nil {
            myReviewButton.titleLabel?.text = "Review Book"
        } else {
            myReviewButton.titleLabel?.text = "My Review"
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (book?.bookshelves.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bookshelvesCell", for: indexPath)
        let bookshelf = book?.bookshelves[indexPath.row]
        cell.textLabel?.text = bookshelf
        return cell
    }
    
    func showActionSheet() {
        let actionSheet = UIAlertController(title: "Choose a bookshelf", message: nil, preferredStyle: .actionSheet)
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        var alertList = [UIAlertAction]()
        for shelf in BookController.shared.bookshelves {
            let option = UIAlertAction(title: shelf.name, style: .default) { action in
                guard let book = self.book else {return}
                let bookShelf = shelf
                bookShelf.books.append(book)
                book.bookshelves.append(bookShelf.name)
                self.updateViews()
                self.tableView.reloadData()
            }
            alertList.append(option)
        }
        
        for alert in alertList {
            actionSheet.addAction(alert)
        }
        actionSheet.addAction(cancel)
    
        present(actionSheet, animated: true, completion: nil)
    }
    
    
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ReviewVC {
            destination.book = book
        }
    }
    
}
