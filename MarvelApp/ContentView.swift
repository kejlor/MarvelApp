//
//  ContentView.swift
//  MarvelApp
//
//  Created by Bartosz Wojtkowiak on 12/05/2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var comicsVM = ComicListViewModel()
    @StateObject private var searchVM = SearchComicListViewModel()
    @StateObject private var favouriteVM = FavouriteComicsViewModel()
    
    var body: some View {
        VStack {
            TabView {
                HomeView()
                    .tag(0)
                    .tabItem {
                        Image(systemName: "house")
                    }
                    .environmentObject(comicsVM)
                    .environmentObject(favouriteVM)
                
                SearchView()
                    .tag(1)
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                    }
                    .environmentObject(searchVM)
                    .environmentObject(favouriteVM)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
