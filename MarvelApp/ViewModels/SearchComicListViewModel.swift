//
//  SearchComicListViewModel.swift
//  MarvelApp
//
//  Created by Bartosz Wojtkowiak on 12/05/2023.
//

import Foundation

@MainActor
final class SearchComicListViewModel: ObservableObject {
    @Published var filteredComics = [ComicViewModel]()
    private var comicsRepository: ComicsRepository
    
    init() {
        self.comicsRepository = ComicsRepository(networkService: NetworkService())
    }
    
    func getComicsByTitle(for title: String) async {
        do {
            try await self.filteredComics = comicsRepository.fetchComicsByTitle(title: title).data.results.compactMap(ComicViewModel.init)
        } catch {
            print("Request failed with error: \(error)")
        }
    }
}


