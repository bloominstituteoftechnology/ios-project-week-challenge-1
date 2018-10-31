//
//  SearchTVC.swift
//  iOBooks
//
//  Created by Nikita Thomas on 10/29/18.
//  Copyright © 2018 Nikita Thomas. All rights reserved.
//

import UIKit

class SearchTVC: UITableViewController, UISearchBarDelegate, SearchCellDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else {return}
        guard !text.isEmpty else {return}
        
        BookController.shared.search(term: text) {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func showActionSheet(for index: Int) {
        let actionSheet = UIAlertController(title: "Choose a bookshelf", message: nil, preferredStyle: .actionSheet)
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        let newShelf = UIAlertAction(title: "New Bookshelf", style: .default) { action in
            let sb = UIStoryboard(name: "Main", bundle: nil)
            
            if let destination = sb.instantiateViewController(withIdentifier: "popup") as? CreateBookshelfVC {
                destination.bookItem = BookController.shared.bookSearch?.items[index]
                    self.present(destination, animated: true, completion: {
                        // Set destination bookItem == the book item
                    })
            }
            
        }
        actionSheet.addAction(newShelf)
        
        var alertList = [UIAlertAction]()
        for shelf in BookController.shared.bookshelves {
            let option = UIAlertAction(title: shelf.name, style: .default) { action in
                guard let book = BookController.shared.bookSearch?.items[index] else {fatalError("Book scam in alert list")}
                
                let bookShelf = shelf
                if let imageLinks = book.volumeInfo.imageLinks {
                    let bookObject = BookController.shared.newBook(name: book.volumeInfo.title, image:(imageLinks.smallThumbnail))
                    bookShelf.books.append(bookObject)
                    bookObject.bookshelves.append(bookShelf.name)
                }
            }
            alertList.append(option)
        }
        
        for alert in alertList {
            actionSheet.addAction(alert)
        }
        actionSheet.addAction(cancel)
        
        
        present(actionSheet, animated: true, completion: nil)
    }
    
    func addBookButtonPressed(on cell: UITableViewCell) {
        showActionSheet(for: cell.tag)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return BookController.shared.bookSearch?.items.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath) as! SearchCell
        guard let book = BookController.shared.bookSearch?.items[indexPath.row] else {fatalError("Book scam")}
        if let imageLinks = book.volumeInfo.imageLinks {
            ImageLoader.fetchImage(from: URL(string: (imageLinks.smallThumbnail))) { (image) in
                guard let image = image else { return}
                DispatchQueue.main.async {
                    cell.bookImage.image = image
                }
            }
        }
        
        cell.bookNameLabel.text = book.volumeInfo.title
        cell.delegate = self
        cell.tag = indexPath.row
        
        return cell
    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

