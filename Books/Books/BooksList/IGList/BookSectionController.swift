import Foundation
import IGListKit

protocol BookSectionControllerDelegate: class {
    func didSelect(bookModel: BookModel, at index: Int)
}

class BookSectionController: ListSectionController {
    
    // MARK: - Logic Properties
    weak var delegate: BookSectionControllerDelegate?
    var bookSectionModel: BookSectionModel!
    
    override init() {
        super.init()
        displayDelegate = self
    }
    
    override func numberOfItems() -> Int {
        return bookSectionModel.bookModels.count
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: collectionContext!.containerSize.width, height: 100.0)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell = collectionContext?.dequeueReusableCell(of: BookSectionCell.self, for: self, at: index) as! BookSectionCell
        cell.loadUIObjects(bookModel: bookSectionModel.bookModels[index], position: index)
        return cell
    }
    
    override func didUpdate(to object: Any) {
        bookSectionModel = object as? BookSectionModel
    }
    
    override func didSelectItem(at index: Int) {
        delegate?.didSelect(bookModel: self.bookSectionModel.bookModels[index], at: index)
    }
}

// MARK: - ListDisplayDelegate
extension BookSectionController: ListDisplayDelegate {
    
    func listAdapter(_ listAdapter: ListAdapter, willDisplay sectionController: ListSectionController) { }
    
    func listAdapter(_ listAdapter: ListAdapter, didEndDisplaying sectionController: ListSectionController) { }
    
    func listAdapter(_ listAdapter: ListAdapter, willDisplay sectionController: ListSectionController, cell: UICollectionViewCell, at index: Int) {
        guard let cell = cell as? BookSectionCell else { return }
        cell.starDownloadTask()
    }
    
    func listAdapter(_ listAdapter: ListAdapter, didEndDisplaying sectionController: ListSectionController, cell: UICollectionViewCell, at index: Int) {
        guard let cell = cell as? BookSectionCell else { return }
        cell.cancelDownloadTask()
    }
}
