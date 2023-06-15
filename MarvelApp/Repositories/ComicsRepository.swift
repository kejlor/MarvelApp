//
//  ComicsRepository.swift
//  MarvelApp
//
//  Created by Bartosz Wojtkowiak on 15/06/2023.
//

import SwiftUI

public final class ComicsRepository {
    private var networkService: NetworkService
    private var baseURL = "https://gateway.marvel.com/v1/public/comics?ts=\(ENV.TIME_STAMP)&apikey=\(ENV.SERVICE_API_KEY)&hash=\(ENV.SERVICE_HASH)&limit=25&offset=0&orderBy=-onsaleDate"
    
    init() {
        self.networkService = NetworkService()
    }
    
    func fetchComics() async throws -> ComicsResponse {
        return try await networkService.fetchData(url: baseURL)
        
    }
    
    func fetchComicsByTitle(title: String) async throws -> ComicsResponse {
        let comicsURL = baseURL + "&title=\(title)"
        return try await networkService.fetchData(url: comicsURL)
    }
}
