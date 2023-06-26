//
//  FavouritesComicsView.swift
//  MarvelApp
//
//  Created by Bartosz Wojtkowiak on 23/06/2023.
//

import SwiftUI

struct FavouritesComicsView: View {
    @EnvironmentObject var favouritesVM: FavouritesComicsViewModel
    
    var body: some View {
        NavigationStack {
            if favouritesVM.favouritesComics.isEmpty {
                NoDataFoundView(icon: "star.fill", text: "FavouritesComicsViewIsEmpty".localized)
            } else {
                favouriteComicsList
                .navigationDestination(for: ComicViewModel.self) { comic in
                    DetailComicBookView(comicVM: comic)
                }
            }
        }
    }
}

struct FavouritesComicsView_Previews: PreviewProvider {
    static var previews: some View {
        FavouritesComicsView()
            .environmentObject(FavouritesComicsViewModel())
    }
}

extension FavouritesComicsView {
    var favouriteComicsList: some View {
        List(favouritesVM.favouritesComics) { comic in
            NavigationLink(value: comic) {
                ComicListEntry(comicVM: comic)
                    .swipeActions {
                        Button {
                            favouritesVM.contains(comic) ? favouritesVM.remove(comic) : favouritesVM.add(comic)
                        } label: {
                            Image(systemName: favouritesVM.contains(comic) ? "star.slash.fill" : "star")
                        }
                        .tint(favouritesVM.contains(comic) ? .red : .green)
                    }
            }
        }
    }
}
