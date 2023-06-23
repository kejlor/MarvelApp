//
//  FavouriteComicsViewModel.swift
//  MarvelApp
//
//  Created by Bartosz Wojtkowiak on 23/06/2023.
//

import Foundation

final class FavouritesComicsViewModel: ObservableObject {
    private var favouritesComics: [ComicViewModel]
    private let saveKey = "Favourites"
    let userDefaults = PhotosUserDefaults.shared
    
    init() {
        favouritesComics = userDefaults.getFavourites() ?? [ComicViewModel]()
        print(favouritesComics)
    }
    
    func contains(_ comicVM: ComicViewModel) -> Bool {
        favouritesComics.contains(comicVM)
    }
    
    func add(_ comicVM: ComicViewModel) {
        objectWillChange.send()
        favouritesComics.append(comicVM)
        save()
    }
    
    func remove(_ comicVM: ComicViewModel) {
        objectWillChange.send()
        if let index = favouritesComics.firstIndex(of: comicVM) {
            favouritesComics.remove(at: index)
        }
        save()
    }
    
    func save() {
        userDefaults.addComicsToFavourites(value: favouritesComics)
    }
}
