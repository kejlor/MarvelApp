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
                VStack {
                    Image(systemName: "star.fill")
                        .foregroundColor(.secondary)
                        .font(.system(size: 70))
                    
                    Text("FavouritesComicsViewIsEmpty".localized)
                        .bold()
                        .padding(.vertical)
                }
            } else {
                List(favouritesVM.favouritesComics) { comic in
                    NavigationLink(value: comic) {
                        ComicListEntry(comicVM: comic)
                            .swipeActions {
                                Button {
                                    if favouritesVM.contains(comic) {
                                        favouritesVM.remove(comic)
                                    } else {
                                        favouritesVM.add(comic)
                                    }
                                } label: {
                                    Image(systemName: favouritesVM.contains(comic) ? "star.slash.fill" : "star")
                                }
                                .tint(favouritesVM.contains(comic) ? .red : .green)
                            }
                    }
                }
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
