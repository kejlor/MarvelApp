//
//  SearchComicListViewModel.swift
//  MarvelApp
//
//  Created by Bartosz Wojtkowiak on 12/05/2023.
//

import Foundation

final class SearchComicListViewModel: ObservableObject {
    @Published var filteredComics = [ComicViewModel]()
    
    private var networkService: any NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func getComicsByTitle(for title: String) {
        guard let url = URL(string: "https://gateway.marvel.com/v1/public/comics?ts=\(ENV.TIME_STAMP)&apikey=\(ENV.SERVICE_API_KEY)&hash=\(ENV.SERVICE_HASH)&limit=25&offset=0&orderBy=-onsaleDate&title=\(title)") else { return }
        
        self.networkService.downloadData(of: ComicsResponse.self, from: url) { (result) in
            switch result {
            case .success(let comicsRepsonse):
                DispatchQueue.main.async {
                    self.filteredComics = []
                    self.filteredComics = comicsRepsonse.data.results.map(ComicViewModel.init)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}


