//
//  ReviewCollectionViewCell.swift
//  Books-ProjectWeek
//
//  Created by Yvette Zhukovsky on 10/31/18.
//  Copyright © 2018 Yvette Zhukovsky. All rights reserved.
//

import UIKit

class ReviewCollectionViewCell: UICollectionViewCell {
 
    var book: Volume?
    var review: Review?
    
    func updateView() {
        
        guard let review = review else {return}
        
        textReview.text = review.review
        if review.userId != RealFirebase().userId {
            saveButton.delete(nil)
            deleteButton.delete(nil)
        
        }
        

        
    }
    
    
    
    @IBOutlet weak var textReview: UITextView!
    
    
    @IBOutlet weak var saveButton: UIButton!
    
    @IBOutlet weak var deleteButton: UIButton!
    
    @IBAction func save(_ sender: Any) {
    guard let book = book else {return}
        RealFirebase().addReview(review: textReview.text, bookId: book.id) {

            NSLog("could not save book \($0)")
self.updateView()
        }
    }
    
    
    @IBAction func deleteReview(_ sender: Any) {
    
        guard let book = book else {return}
        RealFirebase().deleteReview(bookId: book.id) {
            
           NSLog("could not save book \($0)")
            self.updateView()
        }
    
    
    }
 
    
    
    

}
