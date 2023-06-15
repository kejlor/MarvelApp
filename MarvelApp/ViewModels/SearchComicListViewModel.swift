//
//  SearchComicListViewModel.swift
//  MarvelApp
//
//  Created by Bartosz Wojtkowiak on 12/05/2023.
//

import Foundation
import Combine

@MainActor
final class SearchComicListViewModel: ObservableObject {
    @Published var filteredComics = [ComicViewModel]()
    private var networkService: NetworkService
    
    init() {
        self.networkService = NetworkService()
    }
    
    func getComicsByTitle(for title: String) async {
        do {
            self.filteredComics = try await networkService.loadComicsByTitle(for: title).data.results.compactMap(ComicViewModel.init)
        } catch {
            print("Request failed with error: \(error)")
        }
    }
}


