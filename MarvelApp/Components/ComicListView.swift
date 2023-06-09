//
//  ComicListView.swift
//  MarvelApp
//
//  Created by Bartosz Wojtkowiak on 12/05/2023.
//

import SwiftUI

struct ComicListView: View {
    @EnvironmentObject var vm: ComicListViewModel
    @StateObject var scannerVM = ScannerViewModel()
    @State private var navPath = [ComicViewModel]()
    @EnvironmentObject var favouritesVM: FavouritesComicsViewModel
    var comics: [ComicViewModel]
    @State private var isShowingScanner = false
    
    var body: some View {
        NavigationStack(path: $navPath) {
            List(comics) { comic in
                NavigationLink(value: comic) {
                    let isComicFavourite = favouritesVM.contains(comic)
                    ComicListEntry(comicVM: comic)
                        .swipeActions {
                            Button {
                                if !isComicFavourite {
                                    favouritesVM.add(comic)
                                }
                            } label: {
                                Image(systemName: favouritesVM.contains(comic) ? "star.slash.fill" : "star")
                            }
                            .tint(favouritesVM.contains(comic) ? .red : .green)
                        }
                }
                .task { if comic.id == comics.last?.id {
                    await vm.getMoreComics()
                } }
            }
            .navigationTitle("HomeViewNavigationTitle".localized)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isShowingScanner.toggle()
                    } label: {
                        Image(systemName: "qrcode.viewfinder")
                    }
                }
            }
            .sheet(isPresented: $isShowingScanner) {
                ScannerView()
                    .environmentObject(scannerVM)
                    .onDisappear {
                        navPath.removeAll()
                        Task {
                            if let fetchedComics = try? await scannerVM.getDetailComics(for: scannerVM.lastQrCode), let comicsFromQR = fetchedComics.first {
                                navPath.append(comicsFromQR)
                            }
                        }
                    }
            }
            .navigationDestination(for: ComicViewModel.self) { comic in
                DetailComicBookView(comicVM: comic)
            }
        }
    }
}

struct ComicListView_Previews: PreviewProvider {
    static var previews: some View {
        ComicListView(comics: [ComicViewModel(comic: Comic(id: 1, title: "Avengers #39", description: "Re-live the legendary first journey into the dystopian future of 2013 - where Sentinels stalk the Earth, and the X-Men are humanity's only hope...until they die! Also featuring the first appearance of Alpha Flight, the return of the Wendigo, the history of the X-Men from Cyclops himself...and a demon for Christmas!? ", thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/9/d0/58b5cfb6d5239"), creators: CreatorResponse(items: [Creator(name: "JJ Abrams"), Creator(name: "Allan"), Creator(name: "John Doe")]), urls: [UrlResponse(type: "detail", url: "https://www.marvel.com/comics/issue/183/startling_stories_the_incorrigible_hulk_2004_1?utm_campaign=apiRef&utm_source=080a502746c8a60aeab043387a56eef0")]))])
            .environmentObject(ComicListViewModel())
            .environmentObject(FavouritesComicsViewModel())
    }
}
