//
//  Bookk.swift
//  Book Project
//
//  Created by Ivan Caldwell on 12/10/18.
//  Copyright © 2018 Ivan Caldwell. All rights reserved.
//

import Foundation

struct Book: Codable {
    let totalItems: Int
    let items: [Item]?
}

struct Item: Codable {
    let volumeInfo: VolumeInfo?
}


enum Kind: String, Codable {
    case booksVolume = "books#volume"
}

struct VolumeInfo: Codable {
    let title: String?
    let authors: [String]?
    let publisher, publishedDate, description: String?
    let allowAnonLogging: Bool?
    let contentVersion: String?
    let imageLinks: ImageLinks?
    let subtitle: String?
}

struct ImageLinks: Codable {
    let smallThumbnail, thumbnail: String?
}


