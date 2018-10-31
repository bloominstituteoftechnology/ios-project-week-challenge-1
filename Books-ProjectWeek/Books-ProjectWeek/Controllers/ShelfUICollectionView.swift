//
//  ShelfUICollectionView.swift
//  Books-ProjectWeek
//
//  Created by Yvette Zhukovsky on 10/31/18.
//  Copyright © 2018 Yvette Zhukovsky. All rights reserved.
//

import UIKit

class ShelfUICollectionView: NSObject, UICollectionViewDataSource {
    
    var shelf:Shelf?
    var books:[String:Volume]?
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shelf?.orderedIds.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        if let cell = cell as? ShelfCollectionViewCell {
            guard let bookId = shelf?.orderedIds[indexPath.row] else {return cell}
            cell.book = books?[bookId]
        }
        return cell
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
