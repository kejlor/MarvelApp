//
//  MockNetworkService.swift
//  MarvelAppUnitTests
//
//  Created by Bartosz Wojtkowiak on 20/06/2023.
//

import Foundation
import UIKit

final class MockNetworkService: NetworkService {
    private var decoder = JSONDecoder()
    
    func fetchData<T>(data: Data) async throws -> T where T : Decodable {
        return try decoder.decode(T.self, from: data)
    }
    
    override func fetchImage(url: String) async throws -> Data? {
        return UIImage(systemName: "house.fill")?.pngData()
    }
}
