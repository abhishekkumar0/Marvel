//
//  ComicsData.swift
//  Marvel
//
//  Created by Abhishek on 11/10/23.
//

import Foundation

struct ComicData: Codable {
    let code: Int?
    let status: String?
    let copyright: String?
    let attributionText: String?
    let attributionHTML: String?
    let etag: String?
    var data: ComicResults?
}

struct ComicResults: Codable {
    let offset: Int?
    let limit: Int?
    let total: Int?
    let count: Int?
    var results: [Comic]?
}

struct Comic: Codable {
    let id: Int?
    let digitalId: Int?
    let title: String?
    let issueNumber: Int?
    let variantDescription: String?
    let description: String?
    let modified: String?
    let isbn: String?
    let upc: String?
    let diamondCode: String?
    let ean: String?
    let issn: String?
    let format: String?
    let pageCount: Int?
    let textObjects: [TextObject]?
    let resourceURI: String?
    let urls: [ComicURL]?
    let series: ComicSeries?
    let variants: [ComicVariant]?
    let collections: [ComicCollection]?
    let collectedIssues: [ComicCollectedIssue]?
    let dates: [ComicDate]?
    let prices: [ComicPrice]?
    let thumbnail: ComicThumbnail?
    let images: [ComicImage]?
    let creators: ComicCreators?
    let characters: ComicCharacters?
    let stories: ComicStories?
    let events: ComicEvents?
}

struct TextObject: Codable {
    let type: String?
    let language: String?
    let text: String?
}

struct ComicURL: Codable {
    let type: String?
    let url: String?
}

struct ComicSeries: Codable {
    let resourceURI: String?
    let name: String?
}

struct ComicVariant: Codable {
    let resourceURI: String?
    let name: String?
}

struct ComicCollection: Codable {
    let resourceURI: String?
    let name: String?
}

struct ComicCollectedIssue: Codable {
    let resourceURI: String?
    let name: String?
}

struct ComicDate: Codable {
    let type: String?
    let date: String?
}

struct ComicPrice: Codable {
    let type: String?
    let price: Double?
}

struct ComicThumbnail: Codable {
    let path: String?
    let `extension`: String?
}

struct ComicImage: Codable {
    let path: String?
    let `extension`: String?
}

struct ComicCreators: Codable {
    let available: Int?
    let collectionURI: String?
    let items: [ComicCreator]?
    let returned: Int?
}

struct ComicCreator: Codable {
    let resourceURI: String?
    let name: String?
    let role: String?
}

struct ComicCharacters: Codable {
    let available: Int?
    let collectionURI: String?
    let items: [ComicCharacter]?
    let returned: Int?
}

struct ComicCharacter: Codable {
    let resourceURI: String?
    let name: String?
}

struct ComicStories: Codable {
    let available: Int?
    let collectionURI: String?
    let items: [ComicStory]?
    let returned: Int?
}

struct ComicStory: Codable {
    let resourceURI: String?
    let name: String?
    let type: String?
}

struct ComicEvents: Codable {
    let available: Int?
    let collectionURI: String?
    let items: [ComicEvent]?
    let returned: Int?
}

struct ComicEvent: Codable {
    let resourceURI: String?
    let name: String?
}
