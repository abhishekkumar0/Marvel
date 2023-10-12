//
//  Characters.swift
//  Marvel
//
//  Created by Abhishek on 09/10/23.
//

import Foundation

struct MarvelCharacterData: Codable {
    let code: Int
    let status: String
    var data: CharacterDataContainer
}

struct CharacterDataContainer: Codable {
    let offset, limit, total, count: Int
    var results: [Character]
}

struct Character: Codable {
    let id: Int
    let name, description: String
    let thumbnail: Thumbnail
    let resourceURI: String
    let comics: Comics
    // Add other properties as needed
}

struct Thumbnail: Codable {
    let path: String
    let thumbnailExtension: String

    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}

struct Comics: Codable {
    let available: Int
    let items: [ComicItem]
    // Add other properties as needed
}

struct ComicItem: Codable {
    let resourceURI: String
    let name: String
}
