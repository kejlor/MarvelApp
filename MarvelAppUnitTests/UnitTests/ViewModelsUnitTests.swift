//
//  ViewModelsUnitTests.swift
//  MarvelAppUnitTests
//
//  Created by Bartosz Wojtkowiak on 20/06/2023.
//

import XCTest

@testable import MarvelApp

@MainActor
final class ViewModelsUnitTests: XCTestCase {
    func test_comicListViewModel_should_get_comics() async {
        let comicListVM = ComicListViewModel(comicsRepository: MockComicsRepository(networkService: MockNetworkService()))
        await comicListVM.getComics()
        XCTAssertEqual(1, comicListVM.comics.count)
    }
    
    func test_comicListViewModel_should_get_more_comics() async {
        let comicListVM = ComicListViewModel(comicsRepository: MockComicsRepository(networkService: MockNetworkService()))
        await comicListVM.getComics()
        XCTAssertEqual(1, comicListVM.comics.count)
        await comicListVM.getMoreComics()
        XCTAssertEqual(4, comicListVM.comics.count)
    }
    
    func test_searchComicListVM_should_get_comic_by_title() async {
        let searchComicListVM = SearchComicListViewModel(comicsRepository: MockComicsRepository(networkService: MockNetworkService()))
        await searchComicListVM.getComicsByTitle(for: "Avengers #39")
        XCTAssertEqual("Avengers #39", searchComicListVM.filteredComics[0].title)
    }
    
    func test_imageLoadVM_should_get_image() async {
        let imageLoadVM = ImageLoadViewModel(comicsRepository: MockComicsRepository(networkService: MockNetworkService()))
        await imageLoadVM.getImage()
        XCTAssertEqual(UIImage(systemName: "house")?.pngData(), imageLoadVM.image?.pngData())
    }
}
