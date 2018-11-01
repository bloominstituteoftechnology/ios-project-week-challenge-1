//
//  MLController.swift
//  BookShelf
//
//  Created by Jerrick Warren on 10/31/18.
//  Copyright © 2018 Jerrick Warren. All rights reserved.
//

import Foundation

class MyLibraryController {
    
    var mLM : [MyLibraryModel] = []
    
    // make functions to fetch, save , update, and change from / to firebase
    
    
    static let baseURL = URL(string: "https://booksapp-687db.firebaseio.com/)")!
    
//    func fetchBooks(completion: @escaping () -> Void) {
//        
//        let requestURL = MyLibraryController.baseURL.appendingPathExtension("json")
//        
//        URLSession.shared.dataTask(with: requestURL) { (data, _, error) in
//            if let error = error {
//                NSLog("Error fecting data: \(error)")
//                completion()
//                return
//            }
//            
//            guard let data = data else {
//                NSLog("No data returned from data task.")
//                completion()
//                return
//            }
//            
//            let jsonDecoder = JSONDecoder()
//            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
//            
//            do{
    
    
    
//                let fetchresults = try jsonDecoder.decode(MyLibraryModel), from: data )
//                
//                completion()
//            } catch {
//                NSLog("Error encoding message: \(error)")
//                completion()
//                return
//            }
//            }.resume()
//    }
    

    func createBook(mLM: MyLibraryModel.Book,
                    title:String, author:String,
                    completion: @escaping (Error?) -> Void ){
    }
    
    
    func updateBookshelf(){}
    
    
    
    func deleteBookshelf(){}
    
    
    
}
