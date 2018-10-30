//
//  ReviewVC.swift
//  iOBooks
//
//  Created by Nikita Thomas on 10/29/18.
//  Copyright © 2018 Nikita Thomas. All rights reserved.
//

import UIKit

class ReviewVC: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    @IBAction func saveReviewButton(_ sender: Any) {
        if let text = textView.text, !text.isEmpty {
            book?.review = text
        }
    }
    
    
    var book: Book?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textView.text = book?.review
    }
}
