
import UIKit

class SearchTableViewController: UITableViewController, UISearchBarDelegate {
    let api: API = GoogleBooksApi()
    var volumes = [Volume]()
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchBar.text else {return}
        
        api.search(query: query) {
            (results, error) in
            if let error = error {
                NSLog("search \(error)")
                return
            }
            
            if let items = results?.items {
                self.volumes = items
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return volumes.count
    }
      
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        if let cell = cell as? ImageCellTableViewCell {
            cell.bookVolumes = volumes[indexPath.row]
            cell.textLabel?.text = volumes[indexPath.row].volumeInfo.title
            
            return cell
        }
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? DetailViewController else {return}
        guard let indexPath = tableView.indexPathForSelectedRow else {return}
        destination.newBook = volumes[indexPath.row]
    }
    
    @IBOutlet weak var searchBar: UISearchBar!
}
