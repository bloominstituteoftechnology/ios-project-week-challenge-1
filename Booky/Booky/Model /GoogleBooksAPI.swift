// let book = try? newJSONDecoder().decode(Book.self, from: jsonData)
import Foundation

class GoogleBooksAPI {
    
    static var bookResults: [Book]?
    
    static func searchForBooks(with searchTerm: String, completion: @escaping ([Book]?, Error?) -> Void) {
        
        let baseURL = URL(string: "https://www.googleapis.com/books/v1/volumes")!
        
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let queryParam = ["q": searchTerm]
        components?.queryItems = queryParam.map({URLQueryItem(name: $0.key, value: $0.value)})
        
        guard let request = components?.url else { return }
        
        let dataTask = URLSession.shared.dataTask(with: request) { data, status, error in
            
            guard let status = status as? HTTPURLResponse else { fatalError() }
            guard status.statusCode == 200 else {
                print("Invalid status: \(status.statusCode)")
                return
            }
            print("Okay status code")
            
            guard error == nil, let data = data else {
                if let error = error {
                    NSLog("Error fetching volume data: \(error)")
                    completion(nil, error)
                }
                return
            }
            do {
                let jsonDecoder = JSONDecoder()
                let bookSearchResults = try jsonDecoder.decode(BookResults.self, from: data)
                self.bookResults = bookSearchResults.books

                completion(bookResults, nil)
                
            } catch {
                NSLog("Unable to decode data into book: \(error)")
                completion(nil, error)
                
            }
        }
        dataTask.resume()
    }
    
}
