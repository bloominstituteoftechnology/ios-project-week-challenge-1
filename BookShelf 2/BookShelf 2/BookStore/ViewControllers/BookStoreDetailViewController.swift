//
//  BookStoreDetailViewController.swift
//  BookShelf
//
//  Created by Jerrick Warren on 10/30/18.
//  Copyright © 2018 Jerrick Warren. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class BookStoreDetailViewController: UIViewController {
    
    var mL: MLFeed?
    var mLC: MyLibraryController?
    var notification: LocalNotificationHelper?
    
    var refBooks: DatabaseReference!
    
   
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let bookRecord = bookRecord else { return }
        print(bookRecord.volumeInfo.title)
        
        // connect outlets
        titleLabel.text = bookRecord.volumeInfo.title
        authorLabel.text = bookRecord.volumeInfo.authors?.joined(separator: "\n")
        authorLabel.lineBreakMode = .byWordWrapping
        DescriptionTextView.text = bookRecord.volumeInfo.description
        
        if DescriptionTextView.text == "" {
            DescriptionTextView.text = "No Book Description Available"
        }
        
        // UI borders on Textview 
        DescriptionTextView.layer.borderWidth = 0.5
        
        // load image
        imageLoader()
        
        refBooks = Database.database().reference().child("Books")
        
        refBooks.observe(.value, with: { snapshot in
            print(snapshot.value as Any)
        })
        
    }
    
    func addBooks() {
        let key = refBooks.childByAutoId().key
        
        let book = ["id": key,
                    "bookTitle": titleLabel.text! as String,
                    "bookAuthor": authorLabel.text! as String,
                    "bookImage": testPicture!.thumbnail as String                    ]
        
        refBooks.child(key!).setValue(book)
        
        notification?.scheduleBookDelievery()
        
    }
    
    var bookRecord : Item? {
        didSet {
            if isViewLoaded {
                //UpdateViews
            }
        }
    }
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var DescriptionTextView: UITextView!
    
    @IBAction func saveBookButton(_ sender: Any){
        // grab the information from the book. (Titble and Author)
        guard let bookRecord = bookRecord else { return }
        titleLabel.text = bookRecord.volumeInfo.title
        authorLabel.text = bookRecord.volumeInfo.authors?.joined(separator: "\n")
        
        
        // need to figure how to upload the image text
        // lets try fireBASE!!!! *crossesFingers
        addBooks()
        
       
    }
    
    var testPicture: ImageLinks?

    func imageLoader () {
        ImageLoader.fetchImage(from: URL(string: testPicture!.thumbnail))  { image in
            guard let image = image else { return }
            DispatchQueue.main.async {
                self.bookImage.image = image
            }
        }
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
