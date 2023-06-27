//
//  SearchView.swift
//  MarvelApp
//
//  Created by Bartosz Wojtkowiak on 12/05/2023.
//

import SwiftUI

struct SearchView: View {
    @EnvironmentObject var vm: SearchComicListViewModel
    @State private var text = ""
    @EnvironmentObject var favouritesVM: FavouritesComicsViewModel
    
    var body: some View {
        NavigationStack {
            if vm.filteredComics.isEmpty {
                NoDataFoundView(icon: "book.fill", text: "EmptySearchViewListText".localized)
            } else {
                foundComicsList
                    .navigationDestination(for: ComicViewModel.self) { comic in
                        DetailComicBookView(comicVM: comic)
                    }
            }
        }
        .searchable(text: $text, prompt: "SearchablePrompt".localized)
        .onSubmit(of: .search) {
            Task {
                await vm.getComicsByTitle(for: text)
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
            .environmentObject(SearchComicListViewModel())
            .environmentObject(FavouritesComicsViewModel())
    }
}

extension SearchView {
    var foundComicsList: some View {
        List(vm.filteredComics) { comic in
            NavigationLink(value: comic) {
                ComicListEntry(comicVM: comic)
                    .swipeActions {
                        Button {
                            if !favouritesVM.contains(comic) {
                                favouritesVM.add(comic)
                            }
                        } label: {
                            Image(systemName: favouritesVM.contains(comic) ? "star.slash.fill" : "star")
                        }
                        .tint(favouritesVM.contains(comic) ? .red : .green)
                    }
            }
        }
    }
}
