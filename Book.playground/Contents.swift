import Cocoa
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

//var bookTitle: String
// URLs only fail when you give them illegal characters
let url: URL! = URL(string: "https://www.googleapis.com/books/v1/volumes?q=chicken")

struct Book: Codable {
    let totalItems: Int
    let items: [Item]?
}

struct Item: Codable {
    let volumeInfo: VolumeInfo?
}


enum Kind: String, Codable {
    case booksVolume = "books#volume"
}

struct VolumeInfo: Codable {
    let title: String?
    let authors: [String]?
    let publisher, publishedDate, description: String?
    let allowAnonLogging: Bool?
    let contentVersion: String?
    let imageLinks: ImageLinks?
    let subtitle: String?
}


struct ImageLinks: Codable {
    let smallThumbnail, thumbnail: String?
}


let task = URLSession.shared.dataTask(with: url) { data, status, error in
    guard let status = status as? HTTPURLResponse else { fatalError() }
    guard status.statusCode == 200 else {
        print("Invalid status: \(status.statusCode)")
        return
    }
    print("Okay status code")
    
    guard error == nil, let data = data else {
        if let error = error {
            print("Error retrieving information from service: \(error)")
            return
        }
        print("Error grabbing data")
        return
    }
    
    print("No error and we have data")

    let book = try! JSONDecoder().decode(Book.self, from: data)
    print("\(book.totalItems) received")
    for index in 1 ... 5 {
        guard let title = book.items![index].volumeInfo?.title else { return }
        print (title)
        if
        let urlToImage = book.items![index].volumeInfo?.imageLinks?.thumbnail,
            let imageURL = URL(string: urlToImage),
            let image = NSImage(contentsOf: imageURL) {
            image
        }
    }

}

task.resume()



