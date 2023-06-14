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
    var bag: AnyCancellable?
    
    func getComicsByTitle(for title: String) {
        self.publisher = CombineWebservice().getComicsByTitle(for: title)
        guard let pub = self.publisher else { return }
        
        bag = pub.sink(receiveCompletion: { completion in
            switch completion {
            case .finished:
                break
            case .failure(let error):
                print(error.localizedDescription)
            }
        }, receiveValue: { (comics) in
            self.filteredComics = comics.data.results.compactMap(ComicViewModel.init)
        })
    }
}


