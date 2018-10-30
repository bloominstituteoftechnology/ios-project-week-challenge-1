//
//  ImageCellTableViewCell.swift
//  Books-ProjectWeek
//
//  Created by Yvette Zhukovsky on 10/29/18.
//  Copyright © 2018 Yvette Zhukovsky. All rights reserved.
//

import UIKit

class ImageCellTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


    var bookVolumes: Volume? {
        didSet {
            textLabel?.text = bookVolumes?.volumeInfo.title
            bookVolumes?.volumeInfo.imageLinks.smallThumbnailImage {
                image in
                DispatchQueue.main.async {
                    self.myImageView?.image = image
                }
            }
        }
        
    }
    
    
    
    
    @IBOutlet weak var myImageView: UIImageView!
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
