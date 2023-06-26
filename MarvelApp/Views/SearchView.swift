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
    
    var body: some View {
        NavigationStack {
            if vm.filteredComics.isEmpty {
                NoDataFoundView(icon: "book.fill", text: "EmptySearchViewListText".localized)
            } else {
                ComicListView(comics: vm.filteredComics)
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
    }
}
