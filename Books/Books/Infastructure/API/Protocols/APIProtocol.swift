import Foundation
import SwiftyJSON

protocol APIProtocol: ManagerProtocol {
    
    var book: BookAPIProtocol { get }
    
    func call(withAPIModel apiModel: APIModel,
              completion: ((Result<JSON>) -> Void)?)
}
