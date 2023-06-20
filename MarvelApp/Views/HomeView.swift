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
        .alert(isPresented: $vm.isShowingAlertGetComics) {
            Alert(title: Text("HomeViewAlertGetComicsTitleText".localized), message: Text("HomeViewAlertGetComicsMessageText".localized), dismissButton: .default(Text("HomeViewAlertGetComicsDismissButtonText".localized)))
        }
        .alert(isPresented: $vm.isShowingAlertGetMoreComics) {
            Alert(title: Text("HomeViewAlertGetMoreComicsTitleText".localized), message: Text("HomeViewAlertGetMoreComicsMessageText".localized), dismissButton: .default(Text("HomeViewAlertGetMoreComicsDismissButtonText".localized)))
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
