//
//  ComicListViewModel.swift
//  MarvelApp
//
//  Created by Bartosz Wojtkowiak on 12/05/2023.
//

import Foundation
import Combine

@MainActor
final class ComicListViewModel: ObservableObject {
    @Published var comics = [ComicViewModel]()
    private var networkService: NetworkService
    
    init() {
        self.networkService = NetworkService()
    }
    
    func getComics() async {
        do {
            self.comics = try await networkService.loadComics().data.results.compactMap(ComicViewModel.init)
        } catch {
            print("Request failed with error: \(error)")
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

