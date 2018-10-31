//
//  ShelvesCollectionViewController.swift
//  Books-ProjectWeek
//
//  Created by Yvette Zhukovsky on 10/30/18.
//  Copyright © 2018 Yvette Zhukovsky. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class ShelvesCollectionViewController: UICollectionViewController {
    @IBAction func addShelf(_ sender: Any) {
        let alertController: UIAlertController = UIAlertController(title: "Add Shelf", message: "Please Enter Name for Your New Shelf", preferredStyle: .alert)
        
        //cancel button
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
            //cancel code
        }
        alertController.addAction(cancelAction)
        
        //Create an optional action
        let nextAction: UIAlertAction = UIAlertAction(title: "Add", style: .default) { action -> Void in
            let text = (alertController.textFields?.first as! UITextField).text
            RealFirebase().createShelf(name: text!) {
                NSLog("createShelf: \($0)")
            }
        }
        alertController.addAction(nextAction)
        
        //Add text field
        alertController.addTextField(configurationHandler: {(_) in })
        
        //Present the AlertController
        present(alertController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 0
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        return cell
    }
}
