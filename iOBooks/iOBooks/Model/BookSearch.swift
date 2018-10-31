//
//  Book.swift
//  iOBooks
//
//  Created by Nikita Thomas on 10/29/18.
//  Copyright © 2018 Nikita Thomas. All rights reserved.
//

import Foundation

struct BookSearch: Codable {
    let items: [Item]
}

struct Item: Codable {
    let id, etag: String
    let selfLink: String
    let volumeInfo: VolumeInfo
}

struct VolumeInfo: Codable {
    let title: String
    let authors: [String]?
    let imageLinks: ImageLinks?
}

struct ImageLinks: Codable {
    let smallThumbnail, thumbnail: String
}




