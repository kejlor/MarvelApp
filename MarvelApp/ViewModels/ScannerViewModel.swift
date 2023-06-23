//
//  ScannerViewModel.swift
//  MarvelApp
//
//  Created by Bartosz Wojtkowiak on 22/06/2023.
//

import Foundation

@MainActor
final class ScannerViewModel: ObservableObject {
    
    /// Defines how often we are going to try looking for a new QR-code in the camera feed.
    let scanInterval: Double = 1.0
    
    @Published var torchIsOn: Bool = false
    @Published var lastQrCode: String = "Qr-code goes here"
    @Published var isDisplayingSheet = false
    @Published var isDisplayingDetailComicView = false
    @Published var fetchedComics = [ComicViewModel]()
    private var comicsRepository: ComicsRepository
    
    init(comicsRepository: ComicsRepository = ComicsRepository(networkService: NetworkService())) {
        self.comicsRepository = comicsRepository
    }
    
    func getDetailComics(for id: String) async {
        emptyFetchedComics()
        do {
            try await self.fetchedComics = comicsRepository.fetchDetailComicsById(from: id).data.results.compactMap(ComicViewModel.init)
            isDisplayingSheet = false
            isDisplayingDetailComicView = true
            print(fetchedComics)
        } catch let error {
            print(error)
        }
    }
    
    func emptyFetchedComics() {
        self.fetchedComics = [ComicViewModel]()
    }
    
    func onFoundQrCode(_ code: String) {
        self.lastQrCode = code
    }
}
