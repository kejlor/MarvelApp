//
//  SearchComicListViewModel.swift
//  MarvelApp
//
//  Created by Bartosz Wojtkowiak on 12/05/2023.
//

import Foundation
import Combine

final class SearchComicListViewModel: ObservableObject {
    @Published var filteredComics = [ComicViewModel]()
    private var publisher: AnyPublisher<ComicsResponse, Error>?
    private var bag = Set<AnyCancellable>()
    private var networkService: NetworkService
    
    init() {
        self.networkService = NetworkService()
    }
    
    func getComicsByTitle(for title: String) {        
        networkService.getComicsByTitle(for: title).sink(receiveCompletion: { completion in
            switch completion {
            case .finished:
                break
            case .failure(let error):
                print(error.localizedDescription)
            }
        }, receiveValue: { (comics) in
            self.filteredComics = comics.data.results.compactMap(ComicViewModel.init)
        })
        .store(in: &bag)
    }
}


