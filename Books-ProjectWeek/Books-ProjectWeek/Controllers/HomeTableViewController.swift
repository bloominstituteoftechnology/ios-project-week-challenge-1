//
//  HomeTableViewController.swift
//  Books-ProjectWeek
//
//  Created by Yvette Zhukovsky on 10/30/18.
//  Copyright © 2018 Yvette Zhukovsky. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {
    @IBAction func addShelf(_ sender: Any) {
        let alertController: UIAlertController = UIAlertController(title: "Add Shelf", message: "Please Enter Name for Your New Shelf", preferredStyle: .alert)
        
        //cancel button
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
            //cancel code
        }
        alertController.addAction(cancelAction)
        
        //Create an optional action
        let nextAction: UIAlertAction = UIAlertAction(title: "Add", style: .default) { action -> Void in
            let text = (alertController.textFields?.first as! UITextField).text
            RealFirebase().createShelf(name: text!) {
                self.reload()
                NSLog("createShelf: \($0)")
            }
        }
        alertController.addAction(nextAction)
        
        //Add text field
        alertController.addTextField(configurationHandler: {(_) in })
        
        //Present the AlertController
        present(alertController, animated: true, completion: nil)
    }
 
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NSLog("viewWillAppear")
       self.reload()
        
        
    }
    
    func reload(){
        
        
        let fb = RealFirebase()
        fb.getAllShelves {
            if let error = $1  {
                NSLog("get all shelves \(error)")
                return
            }
            guard let shelves = $0 else {return}
            self.shelves = Array(shelves.values)
            
            fb.getBooks {
                if let error = $1  {
                    NSLog("get all shelves \(error)")
                    return
                }
                
                self.books = $0
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    var shelves:[Shelf]?
    var books:[String:Volume]?
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shelves?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if let cell = cell as? HomeTableViewCell {
            guard let shelves = shelves else {return cell}
            cell.books = books
            cell.shelf = shelves[indexPath.row]
           // NSLog("shelf: \(cell.shelf?.name) books: \(cell.shelf?.ids?.count)")
            return cell
        }
        

        return cell
    }

    
    
    

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue , sender: sender)
        NSLog("segue type \(type(of: segue.destination))")
        if let destination = segue.destination as? DetailViewController {
            if let cell = sender as? ShelfCollectionViewCell {
             destination.newBook = cell.book
            }
            
        }
        
    }
}
