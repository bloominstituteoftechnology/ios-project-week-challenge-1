//
//  CreateBookshelfVC.swift
//  iOBooks
//
//  Created by Nikita Thomas on 10/29/18.
//  Copyright © 2018 Nikita Thomas. All rights reserved.
//

import UIKit

class CreateBookshelfVC: UIViewController {
    
    var bookItem: Item?
    
    @IBOutlet weak var createBookTextField: UITextField!
    
    @IBAction func createButton(_ sender: Any) {
        guard let text = createBookTextField.text, !text.isEmpty else {return}
        if bookItem != nil {
            var theBook = BookController.shared.newBook(name: (bookItem?.volumeInfo.title)!, image: (bookItem?.volumeInfo.imageLinks?.smallThumbnail)!)
            BookController.shared.newShelf(name: text, books: [theBook])
            theBook.bookshelves.append(BookController.shared.bookshelves.last!)
            
            dismiss(animated: true, completion: nil)
        } else {
            BookController.shared.newShelf(name: text, books: [])
            
            dismiss(animated: true, completion: nil)
        }
    }
    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
