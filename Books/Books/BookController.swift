import Foundation

class BookController {
    
    static let shared = BookController()
    private init() {}
    
    func getBookData(searchTerm: String, completion: @escaping ([Book?]) -> Void) {
        var books: [Book] = []
        guard let endpointURL = URL(string: "https://www.googleapis.com/books/v1/volumes?q=\(searchTerm)") else { return }
        
        let currentSession = URLSession(configuration: .default)
        currentSession.dataTask(with: endpointURL) { (data, response, error) in
            if let error = error {
                print(error)
                return
            }
            
            if let validData = data {
                books = self.jsonDataToBooks(data: validData)
                completion(books)
            }
        }
        .resume()
    }
    
    func jsonDataToBooks(data: Data) -> [Book] {
        var books: [Book] = []
        do {
            let jsonData = try JSONSerialization.jsonObject(with: data, options: [])
            
            guard let results = jsonData as? [String: AnyObject] else {
                print("error when casting jsonData to [String: AnyObject]")
                return books
            }
            
            guard let bookResults = results["items"] as? [[String: Any]] else {
                print("error with bookResults")
                return books
            }
            
            for book in bookResults {
                guard let bookID = book["id"] as? String,
                    let volumeInfo = book ["volumeInfo"] as? [String: Any],
                    let title = volumeInfo["title"] as? String,
                    let authors = volumeInfo["authors"] as? [String],
                    let description = volumeInfo["description"] as! String?,
                    let imageDict = volumeInfo["imageLinks"] as? [String: String] else {
                        print("error retrieving book information")
                        return books
                }
                
                let thumbnailURL = imageDict["smallThumbnail"]
                let bookInfo = Book(bookID: bookID, title: title, authors: authors, smallThumbnail: thumbnailURL, description: description)
                books.append(bookInfo)
            }
            return books
        } catch {
            print(error)
        }
        return books
    }
}
