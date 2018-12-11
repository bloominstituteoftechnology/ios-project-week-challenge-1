//
//  BookAPI.swift
//  Book Project
//
//  Created by Ivan Caldwell on 12/10/18.
//  Copyright © 2018 Ivan Caldwell. All rights reserved.
//

import Foundation
class BookAPI {
    //Test address
    static let endpoint = "https://www.googleapis.com/books/v1/volumes?q=quilting"
    
    // Add the completion last
    static func searchForBooks(with searchTerm: String, completion: @escaping ([Book]?, Error?) -> Void) {
        
        // Establish the base url for our search
        guard let baseURL = URL(string: endpoint)
            else { fatalError("Unable to construct baseURL") }
        
        // Decompose it into its components
        guard var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true) else {
            fatalError("Unable to resolve baseURL to components")
        }
        
        // Create the query item using `search` and the search term
        // This automatically does all escaping so it works with web API coding
        // It also adds the equal signs
        // https://swapi.co/api/Book/?search=le
        let searchQueryItem = URLQueryItem(name: "search", value: searchTerm)
        
        // Add in the search term, if you have more than one just add it to the array
        urlComponents.queryItems = [searchQueryItem]
        
        // Recompose all those individual components back into a fully
        // realized search URL
        guard let searchURL = urlComponents.url else {
            NSLog("Error constructing search URL for \(searchTerm)")
            completion(nil, NSError()) // you could do a fatal error instead
            return
        }
        
        // Create a GET request
        var request = URLRequest(url: searchURL)
        request.httpMethod = "GET" // "Please fetch information for me", simplest REST you can do, equivalent to "read"
        // Asynchronously fetch data
        // Once the fetch completes, it calls its handler either with data
        // (if available) _or_ with an error (if one happened)
        // There's also a URL Response but we're going to ignore it
        let dataTask = URLSession.shared.dataTask(with: request) {
            // This closure is sent three parameters:
            data, _, error in
            // Rehydrate our data by unwrapping it
            guard error == nil, let data = data else {
                if let error = error { // this will always succeed
                    NSLog("Error fetching data: \(error)")
                    completion(nil, error) // we know that error is non-nil
                }
                return
            }
            // We know now we have no error *and* we have data to work with
            // Convert the data to JSON
            // We need to convert snake_case decoding to camelCase
            // Oddly there is no kebab-case equivalent
            // Note issues with naming and show similar thing
            // For example: https://github.com/erica/AssetCatalog/blob/master/AssetCatalog%2BImageSet.swift#L295
            // See https://randomuser.me for future
            do {
                // Declare, customize, use the decoder
                let jsonDecoder = JSONDecoder()
                
                // Perform decoding into [Book] stored in BookSearchResults
                let books = try jsonDecoder.decode(Book.self, from: data)
             
                
                // Send back the results to the completion handler
                completion(, nil)
                
            } catch {
                NSLog("Unable to decode data into books: \(error)")
                completion(nil, error)
                //        return
            }
        }
        
        // A data task needs to be run. To start it, you call `resume`.
        // "Newly-initialized tasks begin in a suspended state, so you need to call this method to start the task."
        dataTask.resume()
    }
}
