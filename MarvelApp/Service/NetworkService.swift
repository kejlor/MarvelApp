//
//  NetworkService.swift
//  MarvelApp
//
//  Created by Bartosz Wojtkowiak on 12/05/2023.
//

import Foundation
import Combine

enum DataError: Error {
    case clientError
    case invalidResponse
    case invalidData
    case decodingError
    case serverError
}

protocol NetworkService {
    func downloadData<T: Decodable>(of type: T.Type, from url: URL, completion: @escaping (Result<T, DataError>) -> Void)
}

final class Webservice: NetworkService {
    func downloadData<T: Decodable>(of type: T.Type, from url: URL, completion: @escaping (Result<T, DataError>) -> Void) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                completion(.failure(.clientError))
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(DataError.invalidResponse))
                return
            }
            
            if 200 ... 299 ~= response.statusCode {
                if let data = data {
                    do {
                        let decodedData: T = try JSONDecoder().decode(T.self, from: data)
                        completion(.success(decodedData))
                    }
                    catch {
                        completion(.failure(DataError.decodingError))
                    }
                } else {
                    completion(.failure(DataError.invalidData))
                }
            } else {
                completion(.failure(DataError.serverError))
            }
        }.resume()
    }
}

class NetworkClient: ObservableObject {
    @Published var comics = [ComicViewModel]()
    
    private var bag = Set<AnyCancellable>()
    
    init() {
        getComics()
    }
    
    func getComics() {
        let urlString = "https://gateway.marvel.com/v1/public/comics?ts=\(ENV.TIME_STAMP)&apikey=\(ENV.SERVICE_API_KEY)&hash=\(ENV.SERVICE_HASH)&limit=25&offset=0&orderBy=-onsaleDate"
        if let url = URL(string: urlString) {
            
            URLSession.shared
                .dataTaskPublisher(for: url)
                .receive(on: DispatchQueue.main)
                .map(\.data)
                .decode(type: [Comic].self, decoder: JSONDecoder())
                .sink { res in
                    
                } receiveValue: { [weak self] comics in
                    let comicsVM = comics.map(ComicViewModel.init)
                    self?.comics = comicsVM
                }
                .store(in: &bag)
        }
    }
}
