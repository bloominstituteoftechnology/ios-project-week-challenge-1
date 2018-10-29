import UIKit

class BookListViewController: UIViewController {

    var books: [Book] = []
    
    @IBOutlet weak var bookListTableView: UITableView!
    @IBOutlet weak var bookSearchBar: UISearchBar!

    override func viewDidLoad() {
        super.viewDidLoad()
        bookListTableView.dataSource = self
        bookListTableView.delegate = self
        
        bookListTableView.rowHeight = UITableView.automaticDimension
        bookListTableView.estimatedRowHeight = 150
        
        bookSearchBar.delegate = self
        DispatchQueue.main.async {
            self.getBookData()
            self.bookListTableView.reloadData()
        }
        
    }
    
    fileprivate func getBookData(){
        BookController.shared.getBookData(searchTerm: "dog") { (books) in
            DispatchQueue.main.async {
                self.books = books as! [Book]
                self.bookListTableView.reloadData()
                self.bookListTableView.setNeedsLayout()
                print(self.books.count)
            }
        }
    }
    
    
    
}

extension BookListViewController: UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: BookTableViewCell = bookListTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! BookTableViewCell
        
        let currentBook = books[indexPath.row]
        cell.titleLabel.text = currentBook.title
        cell.authorLabel.text = currentBook.authors[0]
        

        
        return cell
    }
    
}

extension BookListViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchTerm = searchBar.text {
            let formattedTerm = searchTerm.replacingOccurrences(of: " ", with: "_")
            BookController.shared.getBookData(searchTerm: formattedTerm) { (books) in
                DispatchQueue.main.async {
                    self.books = books as! [Book]
                    self.bookListTableView.reloadData()
                }
            }
        }
    }
    
}
