//
//  ContentView.swift
//  MarvelApp
//
//  Created by Bartosz Wojtkowiak on 12/05/2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var comicsVM = ComicListViewModel(networkService: NetworkServiceFactory.create())
    @StateObject private var searchVM = SearchComicListViewModel(networkService: NetworkServiceFactory.create())
    
    var body: some View {
        VStack {
            TabView {
                HomeView()
                    .tag(0)
                    .tabItem {
                        Image(systemName: "house")
                    }
                    .environmentObject(comicsVM)
                
                SearchView()
                    .tag(1)
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                    }
                    .environmentObject(searchVM)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
