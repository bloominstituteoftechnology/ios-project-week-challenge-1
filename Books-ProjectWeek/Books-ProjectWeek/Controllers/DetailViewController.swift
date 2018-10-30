//
//  DetailViewController.swift
//  Books-ProjectWeek
//
//  Created by Yvette Zhukovsky on 10/29/18.
//  Copyright © 2018 Yvette Zhukovsky. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
    var newBook: Volume?{
        didSet{
            if let book = newBook {
                RealFirebase().storeBooks(volume: book, completion: {
                    NSLog("\($0)") })
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
        author.text = nb.volumeInfo.authors?.joined(separator:" , ")
        descriptionBook.text = nb.volumeInfo.description
     
        
        
        
    }
    
    
    @IBOutlet weak var descriptionBook: UITextView!
    
    
    @IBOutlet weak var bookName: UILabel!
    
    @IBOutlet weak var author: UILabel!
    
    @IBOutlet weak var bookImage: UIImageView!
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
