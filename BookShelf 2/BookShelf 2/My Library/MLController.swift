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
    
    func createBook(mLM: MyLibraryModel.Book,
                    title:String, author:String,
                    completion: @escaping (Error?) -> Void ){
    
        
        
    }
    
    
    func updateBookshelf(){}
    
    
    
    func deleteBookshelf(){}
    
    
    
}
