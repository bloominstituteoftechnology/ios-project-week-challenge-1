import Foundation

protocol BookAPIProtocol: APIService {
    func get(bookQuery: BookQuery, completion: ((Result<[BookModel]>) -> Void)?)
}
