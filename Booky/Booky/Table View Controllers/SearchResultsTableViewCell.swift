//
//  SearchResultsTableViewCell.swift
//  Booky
//
//  Created by Madison Waters on 12/10/18.
//  Copyright © 2018 Jonah Bergevin. All rights reserved.
//

import UIKit

class SearchResultsTableViewCell: UITableViewCell {

    static let reuseIdentifier = "SearchCell"
    
    @IBOutlet weak var bookImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var publisherLabel: UILabel!
    
    var book: Book?
    
}
