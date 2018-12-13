//
//  BookSearchViewController.swift
//  Booky
//
//  Created by Madison Waters on 12/10/18.
//  Copyright © 2018 Jonah Bergevin. All rights reserved.
//

import UIKit

class BookSearchViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBAction func searchBarButton(_ sender: UIButton) {
        updateViews()
    }
    
    @IBAction func cancelSearchButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        updateViews()
    }
    
    func updateViews() {
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else { return }
        searchBar.text = ""
        
        Model.shared.search(for: searchTerm.lowercased()) {
            DispatchQueue.main.async {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    var book: Book?
    var books: [Book] = []
}
