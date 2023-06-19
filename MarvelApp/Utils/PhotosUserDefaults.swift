//
//  PhotosUserDefaults.swift
//  MarvelApp
//
//  Created by Bartosz Wojtkowiak on 19/06/2023.
//

import SwiftUI

final class PhotosUserDefaults {
    static let instance = PhotosUserDefaults()
    
    private init() { }
    
    func addToUserDefaults(key: String, value: UIImage) {
        let data = CoverImage(photo: value).photo
        let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let url = documents.appendingPathComponent(key)
        
        do {
            try data.write(to: url)
            UserDefaults.standard.set(url, forKey: "SavedData")
        } catch {
            print("Unable to Write Data to Disk (\(error))")
        }
    }
    
    func getImage(key: String) -> UIImage? {
        if let data = UserDefaults.standard.data(forKey: key) {
            do {
                let decoder = JSONDecoder()
                let cover = try decoder.decode(CoverImage.self, from: data)
                return UIImage(data: cover.photo)
            } catch {
                print("Unable to get image from User Defaults")
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
