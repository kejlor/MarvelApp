//
//  ComicsRepositoryUnitTests.swift
//  MarvelAppUnitTests
//
//  Created by Bartosz Wojtkowiak on 20/06/2023.
//

import XCTest

@testable import MarvelApp

@MainActor
class ComicsRepositoryUnitTests: XCTestCase {
    func test_should_get_image() async {
        let comicsRepository = ComicsRepository(networkService: MockNetworkService())
        let fetchedImage = try? await comicsRepository.getImage(from: "")
        XCTAssertNotNil(fetchedImage)
    }
    
    func test_urlString_should_return_value() async {
        let comicsRepository = MockComicsRepository(networkService: MockNetworkService())
        XCTAssertEqual("Random string", comicsRepository.urlString)
    }
    
    func test_fetchData_should_not_return_decoded_data() async {
        let networkService = MockNetworkService()
        let decodedType = try? await networkService.fetchData() as ComicsResponse
        XCTAssertNil(decodedType)
    }
    
    func test_fetchImage_should_return_data() async {
        let networkService = MockNetworkService()
        let image = try? await networkService.fetchImage(url: "")
        XCTAssertEqual(Data().self, image.self)
    }
}
