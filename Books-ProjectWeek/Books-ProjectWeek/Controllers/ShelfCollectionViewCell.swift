//
//  ShelfCollectionViewCell.swift
//  Books-ProjectWeek
//
//  Created by Yvette Zhukovsky on 10/31/18.
//  Copyright © 2018 Yvette Zhukovsky. All rights reserved.
//

import UIKit

class ShelfCollectionViewCell: UICollectionViewCell {
    var book: Volume? {
        didSet {
            book?.volumeInfo.imageLinks.thumbnailImage {
                image in
                DispatchQueue.main.async {
                    self.image.image = image
                }
            }
            
        }
        
    }
    
    @IBOutlet weak var image: UIImageView!
    
    
}
