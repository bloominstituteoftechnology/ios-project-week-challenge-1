//
//  Book Controller.swift
//  BookShelf
//
//  Created by Jerrick Warren on 10/29/18.
//  Copyright © 2018 Jerrick Warren. All rights reserved.
//

import UIKit

class BookController {
    
    static let shared = BookController()
    private init (){}
    
    // bookRecords is of Type Item and is an empty array
    var bookRecords: [Item] = []
    
    var searchBC = BookStoreSearchController()
    
    // make crud functions
    
    
     let baseURL = URL(string:"https://www.googleapis.com/books/v1/volumes")!
    
    // run the API
    // fetch function
    // dataTask
    
    func fetchBooks(searchTerm: String, completion: @escaping () -> Void = { } ) {
        
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let queryParam = ["q": searchTerm]
        components?.queryItems = queryParam.map({URLQueryItem(name: $0.key, value: $0.value)})
        
        guard let fetchURL = components?.url else {
            completion()
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: fetchURL) { data, _, error in

            guard error == nil,
                let data = data else {
                    NSLog("Unable to fetch data")
                    completion()
                    return
            }
            
            do {
                let searchResults = try JSONDecoder().decode(BookFeed.self, from: data)
                print(searchResults)
                self.bookRecords = searchResults.items
                completion()
            } catch {
                NSLog("Unable to decode data into book entries\(error)")
                print(String(data:data, encoding: .utf8) ?? "" )
                completion()
            }
        }
        dataTask.resume()
    }
    }

