//
//  FirebaseModel.swift
//  BookProject
//
//  Created by Yvette Zhukovsky on 10/29/18.
//  Copyright © 2018 Yvette Zhukovsky. All rights reserved.
//

import Foundation

protocol Firebase {
    func addTag(id: String, tag: String) throws -> Void
    func delTag(id: String, tag: String) throws -> Void
    func markRead(id: String, read: Bool) throws -> Void

    func createShelf(name: String) throws -> Void
    func deleteShelf(name: String) throws -> Void
    func addBookToShelf(name: String, id: String) throws -> Void
}

struct TaggedBook: Codable {
    let id: String
    let tags: [String]
    let read: Bool
}

struct Shelf: Codable {
    let name: String
    let ids: [String]
}
