//
//  DataResponse.swift
//  MarvelApp
//
//  Created by Bartosz Wojtkowiak on 12/05/2023.
//

import Foundation

struct DataResponse: Decodable {
    let count: Int
    let results: [Comic]
}
