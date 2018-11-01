//
//  ShelvesTableViewController.swift
//  Books-ProjectWeek
//
//  Created by Yvette Zhukovsky on 10/30/18.
//  Copyright © 2018 Yvette Zhukovsky. All rights reserved.
//

import UIKit

class ShelvesTableViewController: UITableViewController {

    let api: Firebase = RealFirebase()
    var shelves = [Shelf]()
    var book:Volume?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        api.getAllShelves {
            (results, error) in
            if let error = error {
                NSLog("getAllShelves \(error)")
                return
            }
            guard let val = results?.values else {return}
            self.shelves = Array(val)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
         
        }
    }
    
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shelves.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        if let cell = cell as? ShelvesTableViewCell {
            cell.shelf = shelves[indexPath.row]
            cell.book = book
            return cell
        }
        
        return cell
    }
    
    
        

       
    }


