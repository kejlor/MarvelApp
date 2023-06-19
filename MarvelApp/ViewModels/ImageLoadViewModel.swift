//
//  ImageLoadViewModel.swift
//  MarvelApp
//
//  Created by Bartosz Wojtkowiak on 12/05/2023.
//

import SwiftUI
import Combine

final class ImageLoadViewModel: ObservableObject {
    @Published var image: UIImage? = nil
    @Published var isLoading = false
    let photosUserDefaults = PhotosUserDefaults.instance
    private var comicsRepository: ComicsRepository
    let urlString: String
    let imageKey: String
    
    init(url: String, key: String) async {
        urlString = url
        imageKey = key
        self.comicsRepository = ComicsRepository()
        await getImage()
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
                let image = UIImage(data: downloadedCover.photo)!
                self.image = image
                self.photosUserDefaults.addToUserDefaults(key: self.imageKey, value: image)
            }
        } catch {
            print("")
        }
    }
}

