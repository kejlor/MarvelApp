//
//  ImageLoadViewModel.swift
//  MarvelApp
//
//  Created by Bartosz Wojtkowiak on 12/05/2023.
//

import SwiftUI

final class ImageLoadViewModel: ObservableObject {
    @Published var image: UIImage? = nil
    @Published var isLoading = true
    let photosUserDefaults = PhotosUserDefaults.shared
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
        do {
            if let image = try await self.comicsRepository.getImage(from: self.urlString) {
                DispatchQueue.main.async {
                    self.image = image
                    self.isLoading = false
                }
            }
        } catch {
            print(error)
        }
    }
}

