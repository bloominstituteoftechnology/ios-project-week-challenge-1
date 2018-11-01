import Foundation

struct BookQuery {
    var searchText: String
    var startIndex: Int
    var maxResults: Int
    enum Filter: String {
        case ebooks = "ebooks"
        case freeEbooks = "free-ebooks"
        case paidEbooks = "paid-ebooks"
    }
    var filter: Filter
    enum OrderBy: String {
        case relevance = "relevance"
        case newest = "newest"
    }
    var orderBy: OrderBy
}

class BookAPIImplementation: BookAPIProtocol {
    
    // MARK: - Protocol Properties
    var baseURL: String
    
    // MARK: - Life Cycle Methods
    required init(baseURL: String) {
        self.baseURL = baseURL
    }
    
    func get(bookQuery: BookQuery, completion: ((Result<[BookModel]>) -> Void)?) {
        let url =
            baseURL +
                "/volumes?" +
                "filter=\(bookQuery.filter.rawValue)&" +
                "q=\(bookQuery.searchText)&" +
                "orderBy=\(bookQuery.orderBy.rawValue)&" +
                "startIndex=\(bookQuery.startIndex)&" +
        "maxResults=\(bookQuery.maxResults)"
        let apiModel = APIModel(method: .get,
                                url: url,
                                headers: nil,
                                params: nil,
                                paramsEncoding: .json)
        Manager.api.call(withAPIModel: apiModel) { result in
            switch result {
            case .success(let json):
                let books = BookParser().parse(fromJSON: json)
                completion?(Result.success(value: books))
            case .failure(let errorAPI):
                completion?(Result.failure(error: errorAPI))
            }
        }
    }
}
