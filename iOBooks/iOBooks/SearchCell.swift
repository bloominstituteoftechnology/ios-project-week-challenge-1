//
//  SearchCell.swift
//  iOBooks
//
//  Created by Nikita Thomas on 10/29/18.
//  Copyright © 2018 Nikita Thomas. All rights reserved.
//

import UIKit


class SearchCell: UITableViewCell {
    
    var delegate: SearchCellDelegate?
    
    @IBOutlet weak var bookShelfButton: UIButton!
    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var bookNameLabel: UILabel!
    @IBAction func addToBookshelfButton(_ sender: Any) {
        delegate?.addBookButtonPressed(on: self)
    }
    

}

protocol SearchCellDelegate {
    func addBookButtonPressed(on cell: UITableViewCell)
}
