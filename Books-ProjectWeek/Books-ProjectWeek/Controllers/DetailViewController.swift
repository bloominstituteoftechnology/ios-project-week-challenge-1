//
//  DetailViewController.swift
//  Books-ProjectWeek
//
//  Created by Yvette Zhukovsky on 10/29/18.
//  Copyright © 2018 Yvette Zhukovsky. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    var newBook: Volume? {
        didSet{
            if let book = newBook {
                RealFirebase().storeBooks(volume: book, completion: {
                    NSLog("storeBooks \($0)")
                })
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let nb = newBook else {return}
        bookName.text = nb.volumeInfo.title
        nb.volumeInfo.imageLinks.thumbnailImage {
            image in
            DispatchQueue.main.async {
                self.bookImage?.image = image
            }
        }
        author.text = nb.volumeInfo.authors?.joined(separator:", ")
        descriptionBook.text = nb.volumeInfo.description
        RealFirebase().isRead(id:nb.id) {
            (rb:ReadBook?, error: Error? ) in
            if let error = error {
                NSLog("isRead \(error)")
                return
            }
            guard let rb = rb else {return}
            DispatchQueue.main.async {
                self.isRead.isOn = rb.read
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination =  segue.destination as? ShelvesTableViewController {
            destination.book = newBook
        }
        if let destination =  segue.destination as? ReviewCollectionViewController {
        destination.book = newBook
        }
    }
    
    
    @IBOutlet weak var descriptionBook: UITextView!
    @IBOutlet weak var bookName: UILabel!
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var isRead: UISwitch!
 
    @IBAction func read(_ sender: UISwitch) {
        RealFirebase().markRead(id:(self.newBook?.id)!, read: sender.isOn) {
            NSLog("switch broken \($0)")
        }
    }
}
