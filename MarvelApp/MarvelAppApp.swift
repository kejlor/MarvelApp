//
//  MarvelAppApp.swift
//  MarvelApp
//
//  Created by Bartosz Wojtkowiak on 12/05/2023.
//

import SwiftUI

@main
struct MarvelAppApp: App {
    @StateObject private var comicsVM = ComicListViewModel(networkService: NetworkServiceFactory.create())
    @StateObject private var searchVM = SearchComicListViewModel(networkService: NetworkServiceFactory.create())
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(comicsVM)
                .environmentObject(searchVM)
        }
    }
}

var ENV: APIKeyable {
    return ProdENV()
}
