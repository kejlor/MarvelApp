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
    @Published var lastQrCode: String = ""
    @Published var fetchedComics = [ComicViewModel]()
    @Published var isDisplayingSheet = false
    private var comicsRepository: ComicsRepository
    
    init(comicsRepository: ComicsRepository = ComicsRepository(networkService: NetworkService())) {
        self.comicsRepository = comicsRepository
    }
    
    func getDetailComics(for id: String) async {
        do {
            try await self.fetchedComics = comicsRepository.fetchDetailComicsById(from: id).data.results.compactMap(ComicViewModel.init)
            print(fetchedComics)
        } catch let error {
            print(error)
        }
    }
    
    func isShowingSheet() {
        self.isDisplayingSheet.toggle()
    }
    
    func onFoundQrCode(_ code: String) async {
        self.lastQrCode = code
        isShowingSheet()
        await getDetailComics(for: code)
    }
    
    func returnFetchedComics() -> ComicViewModel? {
        if let comic = fetchedComics.first {
            return comic
        }
        
        return nil
    }
}
