//
//  BookShelvesTVC.swift
//  iOBooks
//
//  Created by Nikita Thomas on 10/29/18.
//  Copyright © 2018 Nikita Thomas. All rights reserved.
//

import UIKit

class BookShelvesTVC: UITableViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        BookController.shared.downloadBooks { success in
            if success {
                print("Downloaded Books")
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    for shelf in BookController.shared.bookshelves {
                        print(shelf.books)
                    }

                }
            } else {
                print("Couldn't download books")
            }
        }
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return BookController.shared.bookshelves.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bookshelvesCell", for: indexPath)
        
        let shelf = BookController.shared.bookshelves[indexPath.row]
        
        cell.textLabel?.text = shelf.name
        cell.detailTextLabel?.text = String(shelf.books.count)
        return cell
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? BooksTVC {
            guard let indexPath = tableView.indexPathForSelectedRow else {return}
            destination.bookshelf = BookController.shared.bookshelves[indexPath.row]
        }
//        else if let destination = segue.destination as? CreateBookshelfVC {
//            guard segue.identifier == "toAddNewBookShelf" else {return}
//            // Do something when going to CreateBookShelfVC
//        }
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
    

    
}
