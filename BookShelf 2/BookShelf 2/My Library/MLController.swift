//
//  MLController.swift
//  BookShelf
//
//  Created by Jerrick Warren on 10/31/18.
//  Copyright © 2018 Jerrick Warren. All rights reserved.
//

import Foundation
import UIKit

class MyLibraryController {
    
    var mLM : [MLFeed] = []
    
    var libraryRecords: [BookApp] = []
    
    // make functions to fetch, save , update, and change from / to firebase
    
    static let baseURL = URL(string: "https://booksapp-687db.firebaseio.com/")!
    
    func fetchLibraryBooks(completion: @escaping () -> Void) {
        
        let requestURL = MyLibraryController.baseURL.appendingPathExtension("json")
        // https://booksapp-687db.firebaseio.com/.json
        
        URLSession.shared.dataTask(with: requestURL) { (data, _, error) in
            if let error = error {
                NSLog("Error fecting data: \(error)")
                completion()
                return
            }
            
            guard let data = data else {
                NSLog("No data returned from data task.")
                completion()
                return
            }
            
           // let jsonDecoder = JSONDecoder()
            // jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            
            do{
                let bookApp = try JSONDecoder().decode([BookApp].self, from: data)
                print(bookApp)
                print(String(data:data, encoding: .utf8) ?? "" )
              
                
                completion()
            } catch {
                NSLog("Error encoding message: \(error)")
                completion()
                print(String(data:data, encoding: .utf8) ?? "" )
                return
            }
            }.resume()
    }
    

    func createBook(mLM: MLFeed.Book,
                    title:String, author:String,
                    completion: @escaping (Error?) -> Void ){
    }
    
    
    func updateBookshelf(){}
    
    
    
    func deleteBookshelf(){}
    

// FireBase JSON Model
    
    struct BookApp: Codable {
        let books: [String: Book]
        
        enum CodingKeys: String, CodingKey {
            case books = "Books"
        }
    }
    
    struct Book: Codable {
        let bookAuthor, bookTitle, id: String
        let bookImage: String?
    }

    struct MLFeedResults: Codable {
        var books: BookApp
}
    
}
