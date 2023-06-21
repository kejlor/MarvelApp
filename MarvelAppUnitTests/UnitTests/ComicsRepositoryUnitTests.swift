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
    
    func test_fetchData_return_data_type() async {
        struct MyObject: Codable, Equatable {
            var something: String
        }
        let myObject = MyObject(something: "String")
        let encoded = try? JSONEncoder().encode(myObject)
        let networkService = MockNetworkService()
        let decoded = try? await networkService.fetchData(data: encoded ?? Data()) as MyObject
        XCTAssertEqual(myObject.self, decoded.self)
    }
    
    func test_fetchImage_should_return_data() async {
        let networkService = MockNetworkService()
        let house = UIImage(systemName: "house.fill")
        let image = try? await networkService.fetchImage(url: "")
        XCTAssertEqual(house?.pngData(), image)
    }
}
