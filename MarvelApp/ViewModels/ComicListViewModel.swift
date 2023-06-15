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
    private var comicsRepository: ComicsRepository
    
    init() {
        self.comicsRepository = ComicsRepository()
    }
    
    func getComics() async {
        do {
            try await self.comics = comicsRepository.fetchComics().data.results.compactMap(ComicViewModel.init)
        } catch {
            print("Request failed with error: \(error)")
        }
    }
    
    func getMoreComics() async {
        do {
            self.comics.append(contentsOf: try await comicsRepository.fetchMoreComics().data.results.compactMap(ComicViewModel.init))
        } catch {
            print("Request failed with error: \(error)")
        }
    }
}

struct ComicViewModel: Identifiable{
    
    private var comic: Comic
    
    init(comic: Comic) {
        self.comic = comic
    }
    
    var id: Int {
        comic.id ?? 0
    }
    
    var title: String {
        comic.title ?? ""
    }
    
    var description: String? {
        comic.description ?? ""
    }
    
    var thumbnailPath: String {
        comic.thumbnail?.path ?? ""
    }
    
    var creators: String {
        var names: [String] = []
        
        for character in comic.creators?.items ?? [] {
            names.append(character.name)
        }
        
        let joinedNames = names.joined(separator: ", ")
        
        return joinedNames
    }
    
    var moreData: String {
        if comic.urls?[0].type == "detail" {
            return comic.urls?[0].url ?? ""
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

extension ComicViewModel: Hashable {
    
    public func hash(into hasher: inout Hasher) {
        return hasher.combine(id)
    }
    
    static func == (lhs: ComicViewModel, rhs: ComicViewModel) -> Bool {
        return lhs.id == rhs.id
    }
}
