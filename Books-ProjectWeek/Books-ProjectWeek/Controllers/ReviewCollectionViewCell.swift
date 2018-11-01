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
    var reloadData: (() -> Void)?
    
    
    
    
    func updateView() {
        guard let book = book else {return}
        guard let review = review else {return}
        DispatchQueue.main.async {
            
            self.textReview.text = review.review
            if review.userId != RealFirebase().userId {
                self.saveButton.setTitle("", for: .normal)
                self.deleteButton.setTitle("", for: .normal)
                self.textReview.isUserInteractionEnabled = false
                
            }
            
        }
        
        
    }
    
    
    
    @IBOutlet weak var textReview: UITextView!
    
    
    @IBOutlet weak var saveButton: UIButton!
    
    @IBOutlet weak var deleteButton: UIButton!
    
    @IBAction func save(_ sender: Any) {
        guard let book = book else {return}
        RealFirebase().addReview(review: textReview.text, bookId: book.id) {
            
            NSLog("could not save book \($0)")
            guard let review = self.review else {return}
            DispatchQueue.main.async {
               
            self.review = Review(userId:review.userId, review:self.textReview.text, bookId:review.bookId  )
            self.updateView()
            }
            }
    }
    
    
    @IBAction func deleteReview(_ sender: Any) {
        
        guard let book = book else {return}
        RealFirebase().deleteReview(bookId: book.id) {
            
            NSLog("could not save book \($0)")
            self.updateView()
            self.reloadData?()
        }
        
        
    }
    
    
    
    
    
}

