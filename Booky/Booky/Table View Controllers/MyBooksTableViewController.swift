import UIKit

class MyBooksTableViewController: UITableViewController, ModelUpdateClient {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        Firebase<Bookshelf>.fetchRecords { bookshelves in
            if let bookshelves = bookshelves {
                Model.shared.bookshelves = bookshelves
            
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
        
        print("Bookshelf Names: \(Model.shared.bookshelfNames)")
        
        guard let bookshelf = bookshelf else { return }
        
        let names = Model.shared.bookshelfNames.map { $0 }
        var nameString = ""
        for index in names { nameString.append("\(index)") }
        let nameList = nameString
        print("nameList \(nameList)")
        
        if bookshelf.book.id == nameList{
            print("Bookshelf Names2: \(Model.shared.bookshelfNames)")
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Model.shared.delegate = self
    }

    func modelDidUpdate() {
        tableView.reloadData()
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("My Books Count: \(Model.shared.bookshelves.count)")
        return Model.shared.bookshelves.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MyBooksTableViewCell.reuseIdentifier, for: indexPath) as? MyBooksTableViewCell else {
            fatalError("Error casting cell as My Books Table View Cell") }

        let bookshelves = Model.shared.bookshelves[indexPath.row]
        
        // Configure the cell...
        cell.titleLabel.text = bookshelves.book.volumeInfo.title
        cell.publisherLabel.text = bookshelves.book.volumeInfo.publisher
        
        let urlToImage = bookshelves.book.volumeInfo.imageLinks?.thumbnail
        let imageURL = URL(string: urlToImage ?? " ")!
        cell.bookImageView.load(url: imageURL)
        
        let authors = bookshelves.book.volumeInfo.authors.map { $0 }
        var authorString = ""
        for index in authors ?? [] { authorString.append("\(index)") }
        cell.authorLabel.text = authorString
        
        return cell
    }
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        
        Model.shared.delete(at: indexPath) {
            self.tableView.reloadData()
        }
    }
 
    // MARK: - Navigation // BackToDetail

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "BackToDetail" {
            guard let indexPath = tableView.indexPathForSelectedRow,
                let destination = segue.destination as? BookDetailViewController else { return }
            let bookshelf = Model.shared.bookshelves[indexPath.row]
            
//            destination.bookDetailPublisherLabel.text = bookshelf.book.volumeInfo.publisher
//            destination.bookDetailTitleLabel.text = bookshelf.book.volumeInfo.title
//            
//            let urlToImage = bookshelf.book.volumeInfo.imageLinks?.thumbnail
//            let imageURL = URL(string: urlToImage ?? " ")!
//            destination.bookImageView.load(url: imageURL)
//            
//            let authors = bookshelf.book.volumeInfo.authors.map { $0 }
//            var authorString = ""
//            for index in authors ?? [] { authorString.append("\(index)") }
//            destination.bookDetailAuthorLabel.text = authorString
            destination.bookshelf = bookshelf
            
        }
    }

    var book: Book?
    var books: [Book] = []
    
    var bookshelf: Bookshelf?
    var bookshelfNames: [String] = []
    var bookshelves: [Bookshelf] = []
    
}
