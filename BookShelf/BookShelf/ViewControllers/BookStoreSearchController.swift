//
//  SeachBookController.swift
//  BookShelf
//
//  Created by Jerrick Warren on 10/29/18.
//  Copyright © 2018 Jerrick Warren. All rights reserved.
//

import UIKit

class BookStoreSearchController: UITableViewController, UISearchBarDelegate {
    
    let reuseIdendtifier = "bookstorecell"

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }

    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let book = searchBar.text else {return}
        
        BookController.shared.fetchBooks(searchTerm: book.lowercased(), completion: {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return BookController.shared.bookRecords.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdendtifier, for: indexPath) as! BookStoreTableViewCell
        
        let bookRecord = BookController.shared.bookRecords[indexPath.row]
        
        cell.textLabel?.text = bookRecord.volumeInfo.title
        cell.detailTextLabel?.text = bookRecord.volumeInfo.publishedDate
//        cell.bookTitle.text = bookRecord.volumeInfo.title
//        cell.bookAuthor.text = bookRecord.volumeInfo.publisher
        return cell
    }
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        <#code#>
//    }
//
//
}
