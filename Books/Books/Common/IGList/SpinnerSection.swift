import Foundation
import IGListKit

class SpinnerSection: NSObject {
    
}

// MARK: - ListDiffable
extension SpinnerSection: ListDiffable {
    
    func diffIdentifier() -> NSObjectProtocol {
        return self
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        return isEqual(object)
    }
}
