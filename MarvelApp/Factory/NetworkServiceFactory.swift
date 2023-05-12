//
//  NetworkServiceFactory.swift
//  MarvelApp
//
//  Created by Bartosz Wojtkowiak on 12/05/2023.
//

import Foundation

final class NetworkServiceFactory {
    static func create() -> NetworkService {
        return Webservice()
    }
}
