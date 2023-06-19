//
//  DownliadImageView.swift
//  MarvelApp
//
//  Created by Bartosz Wojtkowiak on 12/05/2023.
//

import SwiftUI

struct DownloadImageView: View {
    @StateObject private var imageLoadVM = ImageLoadViewModel()
    var url: String
    var key: String
    
    var body: some View {
        ZStack {
            if imageLoadVM.isLoading {
                ProgressView()
            } else if let image = imageLoadVM.image {
                Image(uiImage: image)
                    .resizable()
            }
        }
        .alert(isPresented: $imageLoadVM.isShowingAlert) {
            Alert(title: Text("Error while downloading"), message: Text("Unable to download cover image"), dismissButton: .default(Text("Ok")))
        }
        .onAppear {
            self.imageLoadVM.urlString = url
            self.imageLoadVM.imageKey = key
        }
        .task {
            await self.imageLoadVM.getImage()
        }
    }
}
