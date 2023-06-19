//
//  ImageLoadViewModel.swift
//  MarvelApp
//
//  Created by Bartosz Wojtkowiak on 12/05/2023.
//

import SwiftUI

final class ImageLoadViewModel: ObservableObject {
    @Published var image: UIImage? = nil
    @Published var isLoading = false
    @Published var isShowingAlert = true
    let photosUserDefaults = PhotosUserDefaults.instance
    private var comicsRepository: ComicsRepository
    var urlString: String = ""
    var imageKey: String = ""
    
    init() {
        self.comicsRepository = ComicsRepository()
    }
    
    func getImage() async {
        if let storedImage = photosUserDefaults.getImage(key: imageKey) {
            image = storedImage
        } else {
            await downloadCoverImage()
        }
    }
    
    func downloadCoverImage() async {
        isLoading = true
        
        do {
            if let downloadedCover = try await comicsRepository.fetchImage(url: urlString) {
                self.isLoading = false
                if let image = UIImage(data: downloadedCover.photo) {
                    self.image = image
                    self.photosUserDefaults.addToUserDefaults(key: self.imageKey, value: image)
                }
            }
        } catch {
            isShowingAlert = true
            print("Error")
        }
    }
}

