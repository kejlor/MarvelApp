//
//  HomeView.swift
//  MarvelApp
//
//  Created by Bartosz Wojtkowiak on 12/05/2023.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var vm: ComicListViewModel
    
    var body: some View {
        VStack {
            if vm.comics.isEmpty {
                ProgressView()
            } else {
                ComicListView(comics: vm.comics)
            }
        }
        .task {
            await vm.getComics()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(ComicListViewModel())
    }
}
