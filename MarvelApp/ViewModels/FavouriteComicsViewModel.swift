//
//  FavouriteComicsViewModel.swift
//  MarvelApp
//
//  Created by Bartosz Wojtkowiak on 23/06/2023.
//

import Foundation

final class FavouriteComicsViewModel: ObservableObject {
    private var favouriteComics: [ComicViewModel]
    private let saveKey = "Favourites"
    let userDefaults = PhotosUserDefaults.shared
    
    init() {
        favouriteComics = userDefaults.getFavourites() ?? [ComicViewModel]()
        print(favouriteComics)
    }
    
    func contains(_ comicVM: ComicViewModel) -> Bool {
        favouriteComics.contains(comicVM)
    }
    
    func add(_ comicVM: ComicViewModel) {
        objectWillChange.send()
        favouriteComics.append(comicVM)
        print("added \(comicVM.title)")
        save()
        print(favouriteComics)
    }
    
    func remove(_ comicVM: ComicViewModel) {
        objectWillChange.send()
        if let index = favouriteComics.firstIndex(of: comicVM) {
            favouriteComics.remove(at: index)
        }
        print("removed \(comicVM.title)")
        save()
        print(favouriteComics)
    }
    
    func save() {
        userDefaults.addComicsToFavourites(value: favouriteComics)
    }
}
