import Foundation

enum ManagerError: Error {
    case startup
}

struct Manager {
    
    static let configurator: ConfiguratorManager = {
        return ConfiguratorManager()
    }()
    
    static let log: LoggerManager = {
        return LoggerManager()
    }()
    
    static let navigation: NavigationManager = {
        return NavigationManager()
    }()
    
    static let api: APIProtocol = {
        let url = configurator.baseURL
        return APIManager(baseURL: url)
    }()
    
    static func startupManagers(completion: ((Result<Bool>) -> Void)?) {
        configuratorStartup(completion: completion)
    }
    
    fileprivate static func configuratorStartup(completion: ((Result<Bool>) -> Void)?) {
        Manager.configurator.startup { managerProtocol, errorProtocol in
            guard managerProtocol != nil else {
                completion?(Result.failure(error: ManagerError.startup))
                return
            }
            logStartup(completion: completion)
        }
    }
    
    fileprivate static func logStartup(completion: ((Result<Bool>) -> Void)?) {
        Manager.log.startup { managerProtocol, errorProtocol in
            guard managerProtocol != nil else {
                completion?(Result.failure(error: ManagerError.startup))
                return
            }
            navigationStartup(completion: completion)
        }
    }
    
    fileprivate static func navigationStartup(completion: ((Result<Bool>) -> Void)?) {
        Manager.navigation.startup { managerProtocol, errorProtocol in
            guard managerProtocol != nil else {
                completion?(Result.failure(error: ManagerError.startup))
                return
            }
            apiStartup(completion: completion)
        }
    }
    
    fileprivate static func apiStartup(completion: ((Result<Bool>) -> Void)?) {
        Manager.api.startup { managerProtocol, errorProtocol in
            guard managerProtocol != nil else {
                completion?(Result.failure(error: ManagerError.startup))
                return
            }
            completion?(Result.success(value: true))
        }
    }
}
