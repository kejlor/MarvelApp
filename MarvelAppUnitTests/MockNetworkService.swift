//
//  MockNetworkService.swift
//  MarvelAppUnitTests
//
//  Created by Bartosz Wojtkowiak on 20/06/2023.
//

import Foundation

class MockNetworkService: NetworkService {
    private var decoder = JSONDecoder()
    
    func fetchData<T>() async throws -> T where T : Decodable {
        return try decoder.decode(T.self, from: Data())
    }
    
    override func fetchImage(url: String) async throws -> Data? {
        return Data()
    }
}
