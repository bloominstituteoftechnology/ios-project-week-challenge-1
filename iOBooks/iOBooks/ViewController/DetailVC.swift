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
    
    @IBAction func readSwitchAction(_ sender: Any) {
        switch readSwitch.isOn {
        case true:
            book?.bookshelves.append(BookController.shared.bookshelves[0])
            BookController.shared.bookshelves[0].books.append(book!)
            book?.read = true
        case false:
            guard let indexPath = book?.bookshelves.firstIndex(where: { $0.name == "Read" }) else {return}
            book?.bookshelves.remove(at: indexPath)
            
            guard let bookIndex = BookController.shared.bookshelves[0].books.firstIndex(where: { $0.name == book?.name }) else {return}
            BookController.shared.bookshelves[0].books.remove(at: bookIndex)
            
            book?.read = false
        }
    }
    
    @IBAction func addToNewBookshelfButton(_ sender: Any) {
    }
    
    var book: Book?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.delegate = self
        tableView.dataSource = self
        updateViews()
    }
    

    
    func updateViews() {
        bookTitle.text = book?.name
        
        readSwitch.setOn(book?.read ?? false, animated: false)
        
        if let smallImage = book?.image {
            ImageLoader.fetchImage(from: URL(string: (smallImage))) { (image) in
                guard let image = image else { return}
                DispatchQueue.main.async {
                    self.bookImage.image = image
                }
            }
        }
        
        if 
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (book?.bookshelves.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bookshelvesCell", for: indexPath)
        let bookshelf = book?.bookshelves[indexPath.row]
        cell.textLabel?.text = bookshelf?.name
        return cell
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? ReviewVC else {return}
        
    }

}
