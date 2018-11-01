import Foundation

// ErrorType
enum ErrorAPI: Error {
    case noNetwork(error: Error?)
    case timeout(error: Error?)
    case networkConnectionLost(error: Error?)
    case general(error: Error?)
    case server_500(error: Error?)
}
