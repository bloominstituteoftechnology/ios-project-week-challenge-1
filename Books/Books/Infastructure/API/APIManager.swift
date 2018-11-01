import Foundation
import Alamofire
import SwiftyJSON

struct APIModel {
    enum HTTPMethod: String {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case patch = "PATCH"
        case delete = "DELETE"
    }
    enum Encoding {
        case urlEncoded
        case json
    }
    var method: HTTPMethod
    var url: String
    var headers: [String: String]?
    var params: [String: Any]?
    var paramsEncoding: Encoding
}

class APIManager: ManagerProtocol, APIProtocol {
    
    // MARK: - Protocol Properties
    fileprivate var baseURL: String
    var book: BookAPIProtocol
    
    // MARK: - Logic  Properties
    fileprivate static let sessionManager: Alamofire.SessionManager = {
        return Alamofire.SessionManager()
    }()
    
    // MARK: - Life Cycle Methods
    init(baseURL: String) {
        self.baseURL = baseURL
        book = BookAPIImplementation(baseURL: baseURL)
    }
    
    func startup(completion: ((ManagerProtocol?, ErrorAPI?) -> Void)?) {
        startNetworkReachabilityObserver()
        completion?(self, nil)
    }
    
    // MARK: - Protocol Methods
    func call(withAPIModel apiModel: APIModel,
              completion: ((Result<JSON>) -> Void)?) {
        guard let method = HTTPMethod(rawValue: apiModel.method.rawValue) else {
            completion?(Result.failure(error: ErrorAPI.general(error: nil)))
            return
        }
        var encoding: ParameterEncoding
        if apiModel.paramsEncoding == .urlEncoded {
            encoding = URLEncoding.default
        } else {
            encoding = JSONEncoding.default
        }
        APIManager.sessionManager.request(apiModel.url,
                                          method: method,
                                          parameters: apiModel.params,
                                          encoding: encoding,
                                          headers: apiModel.headers)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success(let data):
                    completion?(Result.success(value: JSON(data)))
                case .failure(let error):
                    if let err = error as? URLError, case .notConnectedToInternet = err.code {
                        let errorAPI = ErrorAPI.noNetwork(error: error)
                        completion?(Result.failure(error: errorAPI))
                    } else if let err = error as? URLError, case .timedOut = err.code {
                        let errorAPI = ErrorAPI.timeout(error: error)
                        completion?(Result.failure(error: errorAPI))
                    } else if let err = error as? URLError, case .networkConnectionLost = err.code {
                        let errorAPI = ErrorAPI.networkConnectionLost(error: error)
                        completion?(Result.failure(error: errorAPI))
                    } else {
                        let errorAPI = ErrorAPI.general(error: error)
                        completion?(Result.failure(error: errorAPI))
                    }
                }
        }
    }
    
    // MARK: - Private Methods
    fileprivate func startNetworkReachabilityObserver() {
        let reachabilityManager = Alamofire.NetworkReachabilityManager(host: "www.google.com")
        reachabilityManager?.listener = { status in
            switch status {
            case .notReachable:
                Manager.log.debug("The network is not reachable")
            case .unknown :
                Manager.log.debug("It is unknown whether the network is reachable")
            case .reachable(.ethernetOrWiFi):
                Manager.log.debug("The network is reachable over the WiFi connection")
            case .reachable(.wwan):
                Manager.log.debug("The network is reachable over the WWAN connection")
            }
        }
        // start listening
        reachabilityManager?.startListening()
    }
}
