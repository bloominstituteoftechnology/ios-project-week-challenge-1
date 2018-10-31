//
//  BookEntry.swift
//  BookShelf
//
//  Created by Jerrick Warren on 10/30/18.
//  Copyright © 2018 Jerrick Warren. All rights reserved.
//

import UIKit

struct BookFeed: Codable {
    let kind: String
    let totalItems: Int
    let items: [Item]
}

struct Item: Codable {
    let id, etag: String
    let selfLink: String
    let volumeInfo: VolumeInfo
}

enum Country: String, Codable {
    case us = "US"
}


struct VolumeInfo: Codable {
    let title: String
    let authors: [String]?
    let publisher: String?
    let publishedDate: String?
    let description: String?
    let pageCount: Int?
    let averageRating: Double?
    let ratingsCount: Int?
    let imageLinks: ImageLinks
    let language: Language?
    let previewLink: String?
    let infoLink: String?
    let subtitle: String?
}

struct ImageLinks: Codable {
    let smallThumbnail: String
    let thumbnail: String
}

// this for the QR code?
// double check this.
enum TypeEnum: String, Codable {
    case isbn10 = "ISBN_10"
    case isbn13 = "ISBN_13"
    case other = "OTHER"
}

enum Language: String, Codable {
    case en = "en"
}


private enum CodingKeys: String, CodingKey {
    case title, authors, publisher, publishedDate, description, pageCount, averageRating, ratingsCount, previewLink, infoLink, subtitle
}

struct BookFeedResults: Codable {
    var items: [BookFeed]
}

