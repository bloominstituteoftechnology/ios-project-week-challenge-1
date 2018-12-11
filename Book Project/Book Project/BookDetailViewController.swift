//
//  BookDetailViewController.swift
//  Book Project
//
//  Created by Ivan Caldwell on 12/10/18.
//  Copyright © 2018 Ivan Caldwell. All rights reserved.
//

import UIKit



class BookDetailViewController: UIViewController {
    
    
    @IBOutlet weak var bookName: UILabel!
    
    @IBOutlet weak var bookImage: UIImageView!
    // Test string
    let endpoint = URL(string: "https://www.googleapis.com/books/v1/volumes?q=quilting")
    var searchResults: [Book] = []
    var book: Book?
    func downloadRequest() {
        let downloadURL = endpoint //else { return }
        URLSession.shared.dataTask(with: downloadURL!) { (data, urlResponse, error) in
            print("Download Successful")
            do {
                let book = try! JSONDecoder().decode(Book.self, from: data!)
                let title = book.items![0].volumeInfo?.title!
                print(title!)
                let imageAddress = book.items![0].volumeInfo?.imageLinks?.thumbnail
                let imageURL = URL(string: imageAddress!)
                let imageData = try Data(contentsOf: imageURL!)
                
                DispatchQueue.main.async {
                    self.bookName.text = title!
                    self.bookImage.image = UIImage(data: imageData)
                }
                
                
            } catch {
                print(error)
                print("Something went wrong after download")
            }
        }.resume()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        downloadRequest()
        
    }
    
    
    
    
}
