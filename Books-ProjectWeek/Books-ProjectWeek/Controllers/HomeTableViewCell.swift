//
//  HomeTableViewCell.swift
//  Books-ProjectWeek
//
//  Created by Yvette Zhukovsky on 10/31/18.
//  Copyright © 2018 Yvette Zhukovsky. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    var books: [String:Volume]?
    var shelf: Shelf? {
        didSet {
            let ds = ShelfUICollectionView()
            ds.books = books
            ds.shelf = shelf
            collectionView.dataSource = ds
            labelName.text = shelf?.name
        }
    }
    
    
    @IBOutlet weak var labelName: UILabel!
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
