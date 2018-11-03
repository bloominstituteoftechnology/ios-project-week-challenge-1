//
//  ReviewViewController.swift
//  BookShelf
//
//  Created by Jerrick Warren on 11/1/18.
//  Copyright © 2018 Jerrick Warren. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase

class ReviewViewController: UIViewController {

    var mL: MLFeed?
    var mLC: MyLibraryController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //guard let bookRecord = bookRecord else {return}
        
        // connect the outlets
        //reviewTextView.text = bookRecord.volumeInfo
        
        // UI Borders
        reviewTextView.layer.borderWidth = 1
        
        
    }
    
    @IBOutlet weak var reviewTextView: UITextView!
    
    @IBAction func saveReviewButton(_ sender: Any) {
    
    }
    
    var bookRecord : Item? {
        didSet {
            if isViewLoaded {
                //UpdateViews
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
