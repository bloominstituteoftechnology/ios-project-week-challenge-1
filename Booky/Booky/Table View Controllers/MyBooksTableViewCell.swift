import UIKit

class MyBooksTableViewCell: UITableViewCell {

    static let reuseIdentifier = "MyBooksCell"
    
    @IBOutlet weak var bookImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var publisherLabel: UILabel!
    
    @IBAction func readButton(_ sender: Any) {
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
