//
//  Comic.swift
//  MarvelApp
//
//  Created by Bartosz Wojtkowiak on 12/05/2023.
//

import Foundation

struct ComicsResponse: Decodable {
    let data: DataResponse
}

struct Comic: Decodable {
    let id: Int
    let title: String
    let description: String?
    let thumbnail: Thumbnail
    let creators: CreatorResponse
    let urls: [UrlResponse]
}
