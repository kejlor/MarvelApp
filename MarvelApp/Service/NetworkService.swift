//
//  NetworkService.swift
//  MarvelApp
//
//  Created by Bartosz Wojtkowiak on 12/05/2023.
//

import Foundation

final class NetworkService {
    
    enum NetworkServiceError: Error {
        case invalidURL
        case missingData
    }
    
    private func getComics(completion: @escaping (Result<ComicsResponse, Error>) -> Void) {
        guard let url = URL(string: "https://gateway.marvel.com/v1/public/comics?ts=\(ENV.TIME_STAMP)&apikey=\(ENV.SERVICE_API_KEY)&hash=\(ENV.SERVICE_HASH)&limit=25&offset=0&orderBy=-onsaleDate") else {
            completion(.failure(NetworkServiceError.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkServiceError.missingData))
                return
            }
            
            do {
                let comicResponse = try JSONDecoder().decode(ComicsResponse.self, from: data)
                completion(.success(comicResponse))
            } catch {
                completion(.failure(error))
            }
        }
        .resume()
    }
    
    func fetchComicsWithContinuation() async throws -> ComicsResponse {
        let comicsResponse: ComicsResponse = try await withCheckedThrowingContinuation({ continuation in
            getComics { result in
                switch result {
                case .success(let comicsResponse):
                    continuation.resume(returning: comicsResponse)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        })
        
        return comicsResponse
    }
    
    private func getComicsByTitle(for title: String, completion: @escaping (Result<ComicsResponse, Error>) -> Void) {
        guard let url = URL(string: "https://gateway.marvel.com/v1/public/comics?ts=\(ENV.TIME_STAMP)&apikey=\(ENV.SERVICE_API_KEY)&hash=\(ENV.SERVICE_HASH)&limit=25&offset=0&orderBy=-onsaleDate&title=\(title)") else {
            completion(.failure(NetworkServiceError.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkServiceError.missingData))
                return
            }
            
            do {
                let comicResponse = try JSONDecoder().decode(ComicsResponse.self, from: data)
                completion(.success(comicResponse))
            } catch {
                completion(.failure(error))
            }
        }
        .resume()
    }
    
    func fetchComicsByTitleWithContinuation(for title: String) async throws -> ComicsResponse {
        let comicsResponse: ComicsResponse = try await withCheckedThrowingContinuation({ continuation in
            getComicsByTitle(for: title) { result in
                switch result {
                case .success(let comicsResponse):
                    continuation.resume(returning: comicsResponse)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        })
        
        return comicsResponse
    }
}

