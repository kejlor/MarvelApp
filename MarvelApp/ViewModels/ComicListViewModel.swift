//
//  ComicListViewModel.swift
//  MarvelApp
//
//  Created by Bartosz Wojtkowiak on 12/05/2023.
//

import Foundation

@MainActor
final class ComicListViewModel: ObservableObject {
    @Published var comics = [ComicViewModel]()
    @Published var isShowingAlertGetComics = false
    @Published var isShowingAlertGetMoreComics = false
    private var comicsRepository: ComicsRepository
    
    init(comicsRepository: ComicsRepository = ComicsRepository(networkService: NetworkService())) {
        self.comicsRepository = comicsRepository
    }
    
    func getComics() async {
        do {
            try await self.comics = comicsRepository.fetchComics().data.results.compactMap(ComicViewModel.init)
        } catch {
            isShowingAlertGetComics = true
        }
    }
    
    func getMoreComics() async {
        do {
            self.comics.append(contentsOf: try await comicsRepository.fetchMoreComics().data.results.compactMap(ComicViewModel.init))
        } catch {
            isShowingAlertGetMoreComics = true
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
        comic.title ?? "Title not found"
    }
    
    var description: String {
        comic.description ?? "Empty description"
    }
    
    var thumbnailPath: String {
        comic.thumbnail?.path ?? "http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available"
    }
    
    var creators: String {
        var names: [String] = []
        
        for character in comic.creators?.items ?? [] {
            names.append(character.name)
        }
        
        let joinedNames = names.joined(separator: ", ")
        
        if joinedNames == "" {
            return "Creators not found"
        }
        
        return joinedNames
    }
    
    var moreData: String {
        if comic.urls?[0].type == "detail" {
            return comic.urls?[0].url ?? ""
        } else {
            return "More data not found"
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
