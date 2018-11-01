//
//  ReviewCollectionViewController.swift
//  Books-ProjectWeek
//
//  Created by Yvette Zhukovsky on 10/31/18.
//  Copyright © 2018 Yvette Zhukovsky. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class ReviewCollectionViewController: UICollectionViewController {
    var book: Volume?
    var reviews: [Review]?
    
    
    
    @IBAction func addButton(_ sender: Any) {
        let alertController: UIAlertController = UIAlertController(title: "Add Review", message: "Please Enter Review for the Book", preferredStyle: .alert)
        
        //cancel button
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
            //cancel code
        }
        alertController.addAction(cancelAction)
        
        //Create an optional action
        let nextAction: UIAlertAction = UIAlertAction(title: "Add", style: .default) { action -> Void in
            let text = (alertController.textFields?.first as! UITextField).text
            
            guard let book = self.book else {return}
            RealFirebase().addReview(review: text ?? "", bookId: book.id) {
                
                NSLog("could not save book \($0)")
                self.reload()
            }
        }
        alertController.addAction(nextAction)
        
        //Add text field
        alertController.addTextField(configurationHandler: {(_) in })
        
        //Present the AlertController
        present(alertController, animated: true, completion: nil)
        
        
    }
    
    
    
    func reload(){
        guard let book = book else{return}
        RealFirebase().getReviews(bookId:book.id) {
            if let error = $1  {
                NSLog("get all reviews \(error)")
                return
            }
            
            if let reviews = $0 {
                self.reviews = Array(reviews.values)
                NSLog("loaded \(self.reviews?.count ?? 0) reviews")
            } else {
                self.reviews = []
                NSLog("did not load any reviews")
            }
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                
            }
            
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reload()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        // Do any additional setup after loading the view.
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return reviews?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        if let cell = cell as? ReviewCollectionViewCell {
            guard let reviews = reviews else {return cell}
            cell.book = book
            cell.review = reviews[indexPath.row]
            cell.reloadData = self.reload
            cell.updateView()
        }
            return cell
        }
    
        // MARK: UICollectionViewDelegate
        
        /*
         // Uncomment this method to specify if the specified item should be highlighted during tracking
         override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
         return true
         }
         */
        
        /*
         // Uncomment this method to specify if the specified item should be selected
         override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
         return true
         }
         */
        
        /*
         // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
         override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
         return false
         }
         
         override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
         return false
         }
         
         override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
         
         }
         */
        
}
