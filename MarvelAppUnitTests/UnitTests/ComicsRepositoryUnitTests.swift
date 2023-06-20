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
    func test_should_not_get_any_images() async {
        let comicsRepository = ComicsRepository(networkService: MockNetworkService())
        let fetchedImage = try? await comicsRepository.getImage(from: "")
        XCTAssertEqual(fetchedImage, nil)
    }
    
    func test_urlString_should_return_value() async {
        let comicsRepository = MockComicsRepository(networkService: MockNetworkService())
        XCTAssertEqual("Random string", comicsRepository.urlString)
    }
}
