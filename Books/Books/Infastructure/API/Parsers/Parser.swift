import Foundation
import SwiftyJSON

protocol Parser {
    associatedtype T
    func parse(fromJSON json: JSON) -> T
}
