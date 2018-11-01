//
//  Book.swift
//  iOBooks
//
//  Created by Nikita Thomas on 10/29/18.
//  Copyright © 2018 Nikita Thomas. All rights reserved.
//

import Foundation

struct BookSearch: Codable {
    var items: [Item]
}

struct Item: Codable {
    var id, etag: String
    var selfLink: String
    var volumeInfo: VolumeInfo
}

struct VolumeInfo: Codable {
    var title: String
    var authors: [String]?
    var imageLinks: ImageLinks?
}

struct ImageLinks: Codable {
    var smallThumbnail, thumbnail: String
}




