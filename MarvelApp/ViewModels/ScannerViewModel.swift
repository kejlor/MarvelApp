//
//  ScannerViewModel.swift
//  MarvelApp
//
//  Created by Bartosz Wojtkowiak on 22/06/2023.
//

import Foundation

@MainActor
final class ScannerViewModel: ObservableObject {
    @Published var lastQrCode: String = ""
    @Published var fetchedComics = [ComicViewModel]()
    @Published var isDisplayingSheet = false
    private var comicsRepository: ComicsRepository
    
    init(comicsRepository: ComicsRepository = ComicsRepository(networkService: NetworkService())) {
        self.comicsRepository = comicsRepository
    }
    
    func getDetailComics(for id: String) async throws -> [ComicViewModel]? {
        do {
            return try await comicsRepository.fetchDetailComicsById(from: id).data.results.compactMap(ComicViewModel.init)
        } catch let error {
            print(error)
        }
         return nil
    }
}
