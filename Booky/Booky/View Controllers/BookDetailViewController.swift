//
//  BookDetailViewController.swift
//  Booky
//
//  Created by Madison Waters on 12/10/18.
//  Copyright © 2018 Jonah Bergevin. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {

    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var bookshelfTextField: UITextField!
    
    @IBOutlet weak var bookDetailTitleLabel: UILabel!
    @IBOutlet weak var bookDetailAuthorLabel: UILabel!
    @IBOutlet weak var bookDetailPublisherLabel: UILabel!
    
    @IBAction func addToFavorites(_ sender: Any) {
        
        guard let bookshelf = bookshelf else { return }
        let volumeInfo = bookshelf.volumeInfo
        let name = "My Books"
        let myShelf = Bookshelf(name: name, books: bookshelf.books, volumeInfo: volumeInfo)
        Model.shared.add(bookshelf: myShelf) {
            
        }
    }
    
    @IBAction func addToBookshelf(_ sender: Any) {
        
        guard let bookshelf = bookshelf,
        let name = bookshelfTextField.text else { return }
        let volumeInfo = bookshelf.volumeInfo
        
        let shelf = Bookshelf(name: name, books: bookshelf.books, volumeInfo: volumeInfo)
        Model.shared.add(bookshelf: shelf) {}
        bookshelfTextField.text = nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateViews()
    }

    func updateViews() {
        
        guard let book = book else { return }
        
        bookDetailTitleLabel.text = book.volumeInfo.title
        bookDetailPublisherLabel.text = book.volumeInfo.publisher
        
        let urlToImage = book.volumeInfo.imageLinks?.thumbnail
        let imageURL = URL(string: urlToImage ?? " ")!
        bookImageView.load(url: imageURL)
        
        let authors = book.volumeInfo.authors.map { $0 }
        var authorString = ""
        for index in authors ?? [] { authorString.append("\(index)") }
        bookDetailAuthorLabel.text = authorString
    }

    // MARK: - Navigation // DetailToMyBooks

    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "DetailToMyBooks" {
//            guard let destination = segue.destination as? MyBooksTableViewController else { return }
//            let book = Model.shared.book
//            destination.book = book
//        }
//    }
    
    var book: Book?
    var books: [Book] = []
    
    var bookshelf: Bookshelf?
    var bookshelves: [Bookshelf] = []
}
