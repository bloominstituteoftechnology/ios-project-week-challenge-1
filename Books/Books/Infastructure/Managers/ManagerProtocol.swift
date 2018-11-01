import Foundation

protocol ManagerProtocol {
    func startup(completion: ((ManagerProtocol?, ErrorAPI?) -> Void)?)
}
