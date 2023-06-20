//
//  ComicsRepositoryUnitTests.swift
//  MarvelAppUnitTests
//
//  Created by Bartosz Wojtkowiak on 20/06/2023.
//

import XCTest

@testable import MarvelApp
class ComicsRepositoryUnitTests: XCTestCase {
    @MainActor
    func test_should_not_get_any_data() async {
        let comicsRepository = ComicsRepository(networkService: MockNetworkService())
        let fetchedImage = try? await comicsRepository.getImage(from: "")
        XCTAssertEqual(fetchedImage, nil)
    }
}
