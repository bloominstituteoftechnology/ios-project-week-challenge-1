//
//  FirebaseModel.swift
//  BookProject
//
//  Created by Yvette Zhukovsky on 10/29/18.
//  Copyright © 2018 Yvette Zhukovsky. All rights reserved.
//

import Foundation
import UIKit

protocol Firebase {
    func storeBooks(volume: Volume, completion: @escaping (Error?) -> Void) -> Void
    func getBooks(completion: @escaping ([String:Volume]?, Error?) -> Void) -> Void
    
    func markRead(id: String, read: Bool, completion: @escaping (Error?) -> Void) -> Void
    func isRead(id: String, completion: @escaping (ReadBook?, Error?)-> Void)-> Void
    
    func createShelf(name: String, completion: @escaping (Error?) -> Void) -> Void
    func deleteShelf(name: String, completion: @escaping (Error?) -> Void) -> Void
    func renameBookShelf(name:String, newName: String, completion: @escaping (Error?) -> Void) -> Void
    func getAllShelves(completion: @escaping ([String:Shelf]?, Error?)-> Void) -> Void

    func addBookToShelf(name: String, id: String, completion: @escaping (Error?) -> Void ) -> Void
    func delBookFromShelf(name: String, id: String, completion: @escaping (Error?) -> Void) -> Void
}

class RealFirebase: Firebase {
    private static let baseURL = URL(string: "https://books-e1fe5.firebaseio.com/")!
    private let userId = UIDevice.current.identifierForVendor!.uuidString
    
    func isRead(id: String, completion: @escaping (ReadBook?, Error?) -> Void) {
        let url = RealFirebase.baseURL
            .appendingPathComponent(userId)
            .appendingPathComponent("read")
            .appendingPathComponent(id)
            .appendingPathExtension("json")
        
        Fetcher.GET(
            url: url,
            completion: completion
        )
    }
    
    func getAllShelves(completion: @escaping ([String : Shelf]?, Error?) -> Void) {
        let url = RealFirebase.baseURL
            .appendingPathComponent(userId)
            .appendingPathComponent("shelves")
            .appendingPathExtension("json")
        
        Fetcher.GET(
            url: url,
            completion: completion
        )
    }
    
    func storeBooks(volume: Volume, completion: @escaping (Error?) -> Void) {
        let url = RealFirebase.baseURL
            .appendingPathComponent("volumes")
            .appendingPathComponent(volume.id)
            .appendingPathExtension("json")
        
        Fetcher.PUT(
            url: url,
            body: volume,
            completion: convertCompletion(completion: completion)
        )
    }
    
    func getBooks(completion: @escaping ([String:Volume]?, Error?) -> Void) {
        let url = RealFirebase.baseURL
            .appendingPathComponent("volumes")
            .appendingPathExtension("json")
        
        Fetcher.GET(
            url: url,
            completion: completion
        )
    }
    
    private func convertCompletion(completion: @escaping (Error?) -> Void) -> (Nothing?, Error?) -> Void {
        return { completion($1) }
    }
    
    func markRead(id: String, read: Bool, completion: @escaping (Error?) -> Void) {
        let url = RealFirebase.baseURL
            .appendingPathComponent(userId)
            .appendingPathComponent("read")
            .appendingPathComponent(id)
            .appendingPathExtension("json")
        
        Fetcher.PUT(
            url: url,
            body: ReadBook(id: id, read: read),
            completion: convertCompletion(completion: completion)
        )
    }
    
    func deleteShelf(name: String, completion: @escaping (Error?) -> Void) {
        let url = RealFirebase.baseURL
            .appendingPathComponent(userId)
            .appendingPathComponent("shelves")
            .appendingPathComponent(name)
            .appendingPathExtension("json")
        
        Fetcher.DELETE(
            url: url,
            completion: convertCompletion(completion: completion)
        )
    }
    
    func addBookToShelf(name: String, id: String, completion: @escaping (Error?) -> Void) {
        let url = RealFirebase.baseURL
            .appendingPathComponent(userId)
            .appendingPathComponent("shelves")
            .appendingPathComponent(name)
            .appendingPathComponent("ids")
            .appendingPathExtension("json")
        
        Fetcher.POST(
            url: url,
            body: BookID(id:id),
            completion: convertCompletion(completion: completion)
        )
    }
    
    func delBookFromShelf(name: String, id: String, completion: @escaping (Error?) -> Void) {
        let url = RealFirebase.baseURL
            .appendingPathComponent(userId)
            .appendingPathComponent("shelves")
            .appendingPathComponent(name)
            .appendingPathExtension("json")
        
        Fetcher.GET(
            url: url,
            completion: {
                (shelf: Shelf?, error: Error?) in
                if let error = error {
                    completion(error)
                    return
                }
                if let shelf = shelf {
                    let newShelf = Shelf(name: name, ids: shelf.ids.filter {$0.id != id})
                    
                    Fetcher.PUT(
                        url: url,
                        body: newShelf,
                        completion: self.convertCompletion(completion: completion)
                    )
                }
            }
        )
    }
    
    func renameBookShelf(name: String, newName: String, completion: @escaping (Error?) -> Void) {
        let oldUrl = RealFirebase.baseURL
            .appendingPathComponent(userId)
            .appendingPathComponent("shelves")
            .appendingPathComponent(name)
            .appendingPathExtension("json")
        
        let newUrl = RealFirebase.baseURL
            .appendingPathComponent(userId)
            .appendingPathComponent("shelves")
            .appendingPathComponent(newName)
            .appendingPathExtension("json")
        
        Fetcher.GET(
            url: oldUrl,
            completion: {
                (shelf: Shelf?, error: Error?) in
                if let error = error {
                    completion(error)
                    return
                }
                
                if let shelf = shelf {
                    let newShelf = Shelf(name: newName, ids:shelf.ids)
                    
                    Fetcher.PUT(
                        url: newUrl,
                        body: newShelf,
                        completion: {
                            (nothing:Nothing?, error: Error?) in
                            if let error = error {
                                completion(error)
                                return
                            }
                            Fetcher.DELETE(url: oldUrl, completion: self.convertCompletion(completion: completion))
                        }
                    )
                }
            }
        )
    }
    
    func createShelf(name: String, completion: @escaping (Error?) -> Void) {
        let url = RealFirebase.baseURL
            .appendingPathComponent(userId)
            .appendingPathComponent("shelves")
            .appendingPathComponent(name)
            .appendingPathExtension("json")
        
        Fetcher.PUT(
            url: url,
            body: Shelf(name: name, ids:[]),
            completion: convertCompletion(completion: completion)
        )
    }
}

struct ReadBook: Codable {
    let id:String
    let read: Bool
}

struct BookID: Codable {
    let id: String
}

struct Shelf: Codable {
    let name: String
    let ids: [BookID]
}

struct Review: Codable{
    let userId: String
    let review: String
    let bookId: String
}
