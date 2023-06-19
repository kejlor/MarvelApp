//
//  PhotosUserDefaults.swift
//  MarvelApp
//
//  Created by Bartosz Wojtkowiak on 19/06/2023.
//

import SwiftUI

final class PhotosUserDefaults {
    var image: UIImage
    var name: String
    
    init(image: UIImage, name: String) {
        self.image = image
        self.name = name
    }
    
    func addToUserDefaults() {
        let data = CoverImage(photo: image).photo
        let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let url = documents.appendingPathComponent(name)
        
        do {
            try data.write(to: url)
            UserDefaults.standard.set(url, forKey: "SavedData")
        } catch {
            print("Unable to Write Data to Disk (\(error))")
        }
    }
    
    func getImage() -> UIImage {
        if let data = UserDefaults.standard.data(forKey: "SavedData") {
            do {
                let decoder = JSONDecoder()
                let cover = try decoder.decode(CoverImage.self, from: data)
                return UIImage(data: cover.photo)!
            } catch {
                print("")
            }
        }
        
        return UIImage()
    }
}

public struct CoverImage: Codable {
    public let photo: Data
    
    public init(photo: UIImage) {
        self.photo = photo.jpegData(compressionQuality: 0.5)!
    }
}
