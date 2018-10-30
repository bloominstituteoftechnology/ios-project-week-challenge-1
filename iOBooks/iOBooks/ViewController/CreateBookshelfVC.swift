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
    var book: Book?
    
    @IBOutlet weak var createBookTextField: UITextField!
    
    @IBAction func createButton(_ sender: Any) {
        guard let text = createBookTextField.text, !text.isEmpty else {return}
        if bookItem != nil {
            let theBook = BookController.shared.newBook(name: (bookItem?.volumeInfo.title)!, image: (bookItem?.volumeInfo.imageLinks?.smallThumbnail)!)
            BookController.shared.newShelf(name: text, books: [theBook])
            theBook.bookshelves.append(BookController.shared.bookshelves.last!)
            
            dismiss(animated: true, completion: nil)
        } else if book != nil {
            BookController.shared.newShelf(name: text, books: [book!])
            book?.bookshelves.append(BookController.shared.bookshelves.last!)
            
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
