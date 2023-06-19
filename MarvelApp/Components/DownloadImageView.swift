//
//  DownliadImageView.swift
//  MarvelApp
//
//  Created by Bartosz Wojtkowiak on 12/05/2023.
//

import SwiftUI

struct DownloadImageView: View {
    private var imageLoadVM: ImageLoadViewModel
    
    init(url: String, key: String) async  {
        self.imageLoadVM = await ImageLoadViewModel(url: url, key: key)
    }
    
    var body: some View {
        ZStack {
            if imageLoadVM.isLoading {
                ProgressView()
            } else if let image = imageLoadVM.image {
                Image(uiImage: image)
                    .resizable()
            }
        }
    }
}
