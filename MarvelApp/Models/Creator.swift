//
//  Creator.swift
//  MarvelApp
//
//  Created by Bartosz Wojtkowiak on 12/05/2023.
//

import Foundation

struct CreatorResponse: Codable {
    let items: [Creator]
}

struct Creator: Codable {
    let name: String
}
