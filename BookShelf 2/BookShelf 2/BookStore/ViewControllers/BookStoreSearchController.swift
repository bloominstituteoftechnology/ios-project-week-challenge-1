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

    var bookRecords = [Item]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        searchBar.delegate = self
        tableView.rowHeight = 120
        
        
        
    }
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //searchBar.delegate = self
//        tableView.rowHeight = UITableView.automaticDimension
//        tableView.estimatedRowHeight = 300
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
        
//        cell.textLabel?.text = bookRecord.volumeInfo.title
//        cell.detailTextLabel?.text = bookRecord.volumeInfo.publishedDate
        cell.bookTitle.text = bookRecord.volumeInfo.title
        cell.bookAuthor.text = bookRecord.volumeInfo.publisher
        cell.layer.borderWidth = 1
        
        // THIS TOOK FOREVER!  ATS Settings in pList!
        ImageLoader.fetchImage(from: URL(string: bookRecord.volumeInfo.imageLinks.smallThumbnail)) { image in
            guard let image = image else { return }
            DispatchQueue.main.async {
                cell.bookImage.image = image
            }}
            
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? BookStoreDetailViewController,
        let indexPath = tableView.indexPathForSelectedRow else {return}
        
        // need to set the imageLinks
        destination.testPicture = BookController.shared.bookRecords[indexPath.row].volumeInfo.imageLinks
       destination.bookRecord = BookController.shared.bookRecords[indexPath.row]
       
        print(destination.bookRecord = BookController.shared.bookRecords[indexPath.row])
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "bookstoredetailsegue", sender: tableView)
    }


}
