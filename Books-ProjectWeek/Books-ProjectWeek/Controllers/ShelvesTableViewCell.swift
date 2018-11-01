//
//  ShelvesTableViewCell.swift
//  Books-ProjectWeek
//
//  Created by Yvette Zhukovsky on 10/30/18.
//  Copyright © 2018 Yvette Zhukovsky. All rights reserved.
//

import UIKit

class ShelvesTableViewCell: UITableViewCell {

    var book: Volume?{
        didSet {
            updateView()
        }
    }
    var shelf: Shelf?{
        didSet {
            updateView()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func updateView() {
        guard let shelf = shelf else {return}
        guard let book = book else {return}
        isInShelf.isOn = shelf.hasBook(id: book.id)
        textLabel?.text = shelf.name
    }
    
    @IBOutlet weak var isInShelf: UISwitch!
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    @IBAction func inShelf(_ sender: Any) {
        guard let shelf = shelf else {return}
        guard let book = book else {return}
        let fb = RealFirebase()
        let fun = isInShelf.isOn ? fb.addBookToShelf : fb.delBookFromShelf
        fun(shelf.name, book.id) {
            if $0 != nil { return }
            
        }
        
    }
    
    
}
