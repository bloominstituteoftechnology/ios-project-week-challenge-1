

class ConfiguratorManager: ManagerProtocol {
    
    // MARK: - Constant properties
    let baseURL = "https://www.googleapis.com/books/v1"
    let defaultString = ""
    
    // MARK: - Protocol methods
    func startup(completion: ((ManagerProtocol?, ErrorAPI?) -> Void)?) {
        completion?(self, nil)
    }
}
