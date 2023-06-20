//
//  PhotosUserDefaults.swift
//  MarvelApp
//
//  Created by Bartosz Wojtkowiak on 19/06/2023.
//

import SwiftUI

final class PhotosUserDefaults {
    static let shared = PhotosUserDefaults()
    
    private init() { }
    
    func addToUserDefaults(key: String, value: UIImage) {
        let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let url = documents.appendingPathComponent(key)
        
        UserDefaults.standard.set(url, forKey: "SavedData")
    }
    
    func getImage(key: String) -> UIImage? {
        if let data = UserDefaults.standard.data(forKey: key) {
            return UIImage(data: data)
        }
        
        return nil
    }
}

