//
//  ViewModelsUnitTests.swift
//  MarvelAppUnitTests
//
//  Created by Bartosz Wojtkowiak on 20/06/2023.
//

import XCTest

@testable import MarvelApp

@MainActor
class ViewModelsUnitTests: XCTestCase {
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
    
    func test_imageLoadVM_should_download_cover_image() async {
        let imageLoadVM = ImageLoadViewModel(comicsRepository: MockComicsRepository(networkService: MockNetworkService()))
        imageLoadVM.urlString = "car"
        imageLoadVM.imageKey = "car"
        await imageLoadVM.getImage()
        let temporaryImage = imageLoadVM.image
        await imageLoadVM.downloadCoverImage()
        XCTAssertEqual(temporaryImage?.pngData(), imageLoadVM.image?.pngData())
        XCTAssertEqual(false, imageLoadVM.isLoading)
        XCTAssertEqual("car", imageLoadVM.urlString)
    }
    
    func test_add_to_user_defaults_should_add_and_get() {
        if let catImage = UIImage(systemName: "cat") {
            PhotosUserDefaults.shared.addToUserDefaults(key: "cat", value: catImage)
        }
        XCTAssertEqual(UIImage(systemName: "cat"), PhotosUserDefaults.shared.getImage(key: "cat"))
    }
}
