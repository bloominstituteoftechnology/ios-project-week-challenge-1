//
//  SearchResultsTableViewController.swift
//  Booky
//
//  Created by Madison Waters on 12/10/18.
//  Copyright © 2018 Jonah Bergevin. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController, ModelUpdateClient {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Model.shared.delegate = self
    }
    
    func modelDidUpdate() {
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Model.shared.numberOfBooks()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultsTableViewCell.reuseIdentifier, for: indexPath) as? SearchResultsTableViewCell else {
            fatalError("Error cast cell as Search Results Table View Cell") }
        
        let books = Model.shared.books[indexPath.row]
        
        // Configure the cell...
        cell.titleLabel.text = books.volumeInfo.title
        cell.publisherLabel.text = books.volumeInfo.publisher
        
        let urlToImage = books.volumeInfo.imageLinks?.thumbnail
        let imageURL = URL(string: urlToImage ?? " ")!
        cell.bookImageView.load(url: imageURL)
        
        let authors = books.volumeInfo.authors.map { $0 }
        var authorString = ""
        for index in authors ?? [] { authorString.append("\(index)") }
        cell.authorLabel.text = authorString
        
        return cell
    }

    // MARK: - Navigation
                  // This Table View // ViewBookshelves
    // BookSearch // BookDetail // AddBookshelf

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "BookDetail" {
            guard let indexPath = tableView.indexPathForSelectedRow,
                let destination = segue.destination as? BookDetailViewController else { return }
            let book = Model.shared.books[indexPath.row]
            destination.book = book
            //let bookshelf = Model.shared.bookshelves[indexPath.row]
            //destination.bookshelf = bookshelf
        }
        
        else if segue.identifier == "BookSearch" {
            guard let destination = segue.destination as? BookSearchViewController else { return }
            let book = Model.shared.book
            destination.book = book
        }
    }
    
    var book: Book?
    var books: [Book] = []
    
    var bookshelf: Bookshelf?
    var bookshelves: [Bookshelf] = []
    
}
