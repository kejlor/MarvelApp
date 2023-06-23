//
//  ComicsRepository.swift
//  MarvelApp
//
//  Created by Bartosz Wojtkowiak on 15/06/2023.
//

import SwiftUI

public class ComicsRepository {
    private var networkService: NetworkService
    private var baseURL = "https://gateway.marvel.com/v1/public/comics"
    private var offsetLimit = 0
    
    var urlString: String {
        return "\(baseURL)?ts=\(ENV.TIME_STAMP)&apikey=\(ENV.SERVICE_API_KEY)&hash=\(ENV.SERVICE_HASH)&limit=25&offset=\(offsetLimit)&orderBy=-onsaleDate"
    }
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func fetchComics() async throws -> ComicsResponse {
        return try await networkService.fetchData(url: urlString)
        
    }
    
    func fetchMoreComics() async throws -> ComicsResponse {
        self.offsetLimit += 100
        return try await self.fetchComics()
    }
    
    func fetchComicsByTitle(title: String) async throws -> ComicsResponse {
        let comicsURL = urlString + "&title=\(title)"
        return try await networkService.fetchData(url: comicsURL)
    }
    
    func getImage(from string: String) async throws -> UIImage? {
        guard let imageData = try await networkService.fetchImage(url: string) else { return nil }
        return UIImage(data: imageData)
    }
    
    func fetchDetailComicsById(from id: String) async throws -> ComicsResponse {
        baseURL += "/\(id)"
        let detailComicsURL = urlString + "&comicId=\(id)"
        return try await networkService.fetchData(url: detailComicsURL)
    }
}

var ENV: APIKeyable {
    return ProdENV()
}
