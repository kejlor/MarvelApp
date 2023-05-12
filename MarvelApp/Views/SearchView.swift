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
                VStack {
                    Image(systemName: "book.fill")
                        .foregroundColor(.secondary)
                        .font(.system(size: 70))
                    
                    Text("Start typing to find a particular comics.")
                        .bold()
                        .padding(.vertical)
                }
            } else {
                ComicListView(comics: vm.filteredComics)
            }
        }
        .searchable(text: $text, prompt: "Search for a comic book")
        .onSubmit(of: .search) {
            vm.getComicsByTitle(for: text)
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
