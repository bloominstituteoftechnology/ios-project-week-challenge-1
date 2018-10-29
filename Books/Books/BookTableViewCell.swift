//
//  BookTableViewCell.swift
//  Books
//
//  Created by Paul Yi on 10/29/18.
//  Copyright © 2018 Paul Yi. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {

    var currentBook: Book?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var bookImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
