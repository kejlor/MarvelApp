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
    
    var cancellables = Set<AnyCancellable>()
    let manager = PhotosCacheManager.instance
    let photosUserDefaults = PhotosUserDefaults.instance
    
    let urlString: String
    let imageKey: String
    
    init(url: String, key: String) {
        urlString = url
        imageKey = key
        getImage()
    }
    
    func getImage() {
        if let storedImage = photosUserDefaults.getImage(key: imageKey) {
            image = storedImage
        } else {
            downloadImage()
        }
    }
    
    func downloadImage() {
        isLoading = true
        guard let url = URL(string: urlString) else {
            isLoading = false
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] (_) in
                self?.isLoading = false
            } receiveValue: { [weak self] (returnedImage) in
                guard let self = self,
                      let image = returnedImage else { return }
                
                self.image = image
                self.photosUserDefaults.addToUserDefaults(key: self.imageKey, value: image)
            }
            .store(in: &cancellables)
    }
}

