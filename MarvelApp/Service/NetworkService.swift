//
//  NetworkService.swift
//  MarvelApp
//
//  Created by Bartosz Wojtkowiak on 12/05/2023.
//

import Foundation

final class NetworkService {
    var session = URLSession.shared
    private var baseURL = "https://gateway.marvel.com/v1/public/comics?ts=\(ENV.TIME_STAMP)&apikey=\(ENV.SERVICE_API_KEY)&hash=\(ENV.SERVICE_HASH)&limit=25&offset=0&orderBy=-onsaleDate"
    
    enum NetworkServiceError: Error {
        case invalidURL
        case missingData
    }
    
    func loadComics() async throws -> ComicsResponse {
        guard let url = URL(string: baseURL) else { throw NetworkServiceError.invalidURL }
        let (data, _) = try await session.data(from: url)
        let decoder = JSONDecoder()
        return try decoder.decode(ComicsResponse.self, from: data)
    }
    
    func loadComicsByTitle(for title: String) async throws -> ComicsResponse {
        guard let titleURL = URL(string: baseURL + "&title=\(title)") else { throw NetworkServiceError.invalidURL }
        let (data, _) = try await session.data(from: titleURL)
        let decoder = JSONDecoder()
        return try decoder.decode(ComicsResponse.self, from: data)
    }
}

