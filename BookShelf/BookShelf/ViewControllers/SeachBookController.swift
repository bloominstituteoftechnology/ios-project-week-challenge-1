//
//  SeachBookController.swift
//  BookShelf
//
//  Created by Jerrick Warren on 10/29/18.
//  Copyright © 2018 Jerrick Warren. All rights reserved.
//

import UIKit

class SearchBookController: UITableViewController, UISearchBarDelegate {
    
    let reuseIdendtifier = "searchbookcell"

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
        let nib = UINib(nibName: "BookShelfTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: reuseIdendtifier)
    }
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let book = searchBar.text else {return}
        
        BookModel.shared.fetchBooks(searchTerm: book.lowercased(), completion: {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
    }
    
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return BookModel.shared.bookRecords.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdendtifier, for: indexPath) as! BookShelfTableViewCell
        
        let bookRecord = BookModel.shared.bookRecords[indexPath.row]
        
        cell.textLabel?.text = bookRecord.volumeInfo.title
        cell.bookTitle.text = bookRecord.volumeInfo.title
        cell.bookAuthor.text = bookRecord.volumeInfo.publisher
        return cell
    }
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        <#code#>
//    }
//
//
}
