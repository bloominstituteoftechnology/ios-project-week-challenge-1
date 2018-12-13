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
        cell.titleLabel.text = bookshelves.volumeInfo.title
        cell.publisherLabel.text = bookshelves.volumeInfo.publisher
        
        let urlToImage = bookshelves.volumeInfo.imageLinks?.thumbnail
        let imageURL = URL(string: urlToImage ?? " ")!
        cell.bookImageView.load(url: imageURL)
        
        let authors = bookshelves.volumeInfo.authors.map { $0 }
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
 
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

    var book: Book?
    var books: [Book] = []
    
    var bookshelf: Bookshelf?
    var bookshelves: [Bookshelf] = []
    
}
