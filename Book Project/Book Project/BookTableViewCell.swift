//
//  BookTableViewCell.swift
//  Book Project
//
//  Created by Ivan Caldwell on 12/10/18.
//  Copyright © 2018 Ivan Caldwell. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    static let reuseIdentifier = "BookCell"
    @IBOutlet weak var bookTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
