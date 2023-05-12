//
//  ComicListViewModel.swift
//  MarvelApp
//
//  Created by Bartosz Wojtkowiak on 12/05/2023.
//

import Foundation
import Combine

final class ComicListViewModel: ObservableObject {
    @Published var comics = [ComicViewModel]()
    
    private var networkService: any NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func getComics() {
        guard let url = URL(string: "https://gateway.marvel.com/v1/public/comics?ts=\(ENV.TIME_STAMP)&apikey=\(ENV.SERVICE_API_KEY)&hash=\(ENV.SERVICE_HASH)&limit=25&offset=0&orderBy=-onsaleDate") else { return }
        
        self.networkService.downloadData(of: ComicsResponse.self, from: url) { (result) in
            switch result {
            case .success(let comicsRepsonse):
                DispatchQueue.main.async {
                    self.comics = comicsRepsonse.data.results.map(ComicViewModel.init)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

struct ComicViewModel: Identifiable {
    
    private var comic: Comic
    
    init(comic: Comic) {
        self.comic = comic
    }
    
    var id: Int {
        comic.id
    }
    
    var title: String {
        comic.title
    }
    
    var description: String? {
        comic.description ?? ""
    }
    
    var thumbnailPath: String {
        comic.thumbnail.path
    }
    
    var creators: String {
        var names: [String] = []
        
        for character in comic.creators.items {
            names.append(character.name)
        }
        
        let joinedNames = names.joined(separator: ", ")
        
        return joinedNames
    }
    
    var moreData: String {
        if comic.urls[0].type == "detail" {
            return comic.urls[0].url
        } else {
            return ""
        }
    }
}

struct CreatorViewModel: Identifiable {
    
    private var creator: Creator
    
    init(creator: Creator) {
        self.creator = creator
    }
    
    var id: String {
        creator.name
    }
    
    var name: String {
        creator.name
    }
}

