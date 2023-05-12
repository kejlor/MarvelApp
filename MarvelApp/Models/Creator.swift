//
//  Creator.swift
//  MarvelApp
//
//  Created by Bartosz Wojtkowiak on 12/05/2023.
//

import Foundation

struct CreatorResponse: Decodable {
    let items: [Creator]
}

struct Creator: Decodable {
    let name: String
}
