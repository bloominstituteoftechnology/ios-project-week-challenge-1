import Foundation

protocol APIService {
    var baseURL: String { get set }
    init(baseURL: String)
}
