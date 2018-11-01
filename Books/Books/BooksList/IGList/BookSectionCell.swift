import Foundation
import Anchorage
import Kingfisher

class BookSectionCell: UICollectionViewCell {
    
    // MARK: - UI Properties
    private var imageView = UIImageView()
    private var titleLabel = UILabel()
    private var subtitleLabel = UILabel()
    private var authorsLabel = UILabel()
    private var averageRatingLabel = UILabel()
    
    // MARK: - Logic Properties
    private var bookModel: BookModel!
    private var position: Int!
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupComponents()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View lifecycle
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        titleLabel.text = ""
        subtitleLabel.text = ""
        authorsLabel.text = ""
        averageRatingLabel.text = ""
    }
    
    // MARK: - Load UI Methods
    func loadUIObjects(bookModel: BookModel, position: Int) {
        // logic
        self.bookModel = bookModel
        self.position = position
        
        // ui
        titleLabel.text = (bookModel.title ?? "Title: N/A")
        subtitleLabel.text =  (bookModel.subtitle ?? "Subtitle: N/A")
        var authorsText: String?
        if let authors = bookModel.authors {
            authorsText = authors.joined(separator: ", ")
        }
        authorsLabel.text = "Authors: " + (authorsText ?? "N/A")
        var averageRatingText: String?
        if let averageRating = bookModel.averageRating {
            averageRatingText = String(averageRating)
        }
        averageRatingLabel.text = "Rating: " + (averageRatingText ?? "N/A")
    }
    
    func updateIsReadLabel(bookModel: BookModel) {
        self.bookModel = bookModel
    }
    
    // MARK: - Setup Methods
    private func setupComponents() {
        // imageView
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        contentView.addSubview(imageView)
        
        // titleLabel
        titleLabel.font = UIFont.boldSystemFont(ofSize: 17)
        titleLabel.textColor = Color.black
        contentView.addSubview(titleLabel)
        
        // subtitleLabel
        subtitleLabel.font = UIFont.systemFont(ofSize: 15)
        subtitleLabel.textColor = Color.black
        contentView.addSubview(subtitleLabel)
        
        // authorsLabel
        authorsLabel.font = UIFont.italicSystemFont(ofSize: 15)
        authorsLabel.textColor = Color.gray
        contentView.addSubview(authorsLabel)
        
        // averageRatingLabel
        averageRatingLabel.font = UIFont.systemFont(ofSize: 13)
        averageRatingLabel.textColor = Color.gray
        contentView.addSubview(averageRatingLabel)
    }
    
    private func setupConstraints() {
        // imageView
        imageView.leftAnchor == contentView.leftAnchor + 10.0
        imageView.centerYAnchor == contentView.centerYAnchor
        imageView.widthAnchor == 80.0
        imageView.heightAnchor == 80.0
        
        // titleLabel
        titleLabel.topAnchor == imageView.topAnchor
        titleLabel.leftAnchor == imageView.rightAnchor + 10.0
        titleLabel.rightAnchor <= contentView.rightAnchor - 10.0
        
        // subtitleLabel
        subtitleLabel.topAnchor == titleLabel.bottomAnchor
        subtitleLabel.leftAnchor == titleLabel.leftAnchor
        subtitleLabel.rightAnchor <= contentView.rightAnchor - 10.0
        
        // authorsLabel
        authorsLabel.topAnchor == subtitleLabel.bottomAnchor
        authorsLabel.leftAnchor == titleLabel.leftAnchor
        authorsLabel.rightAnchor <= contentView.rightAnchor - 10.0
        
        // averageRatingLabel
        averageRatingLabel.topAnchor == authorsLabel.bottomAnchor
        averageRatingLabel.leftAnchor == titleLabel.leftAnchor
        averageRatingLabel.rightAnchor <= contentView.rightAnchor - 10.0
    }
    
    // MARK: - Public Methods
    func starDownloadTask() {
        guard let thumbnail = bookModel.thumbnail else { return }
        let imageTransition = ImageTransition.fade(0.5)
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(with: URL(string: thumbnail), options: [.transition(imageTransition)])
    }
    
    func cancelDownloadTask() {
        imageView.kf.cancelDownloadTask()
    }
}
