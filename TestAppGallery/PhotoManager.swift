//
//  PhotoManager.swift
//  TestAppGallery
//
//  Created by Olga Dragunova on 30.03.2022.
//

import Foundation
import SwiftyVK

class PhotoManager {
    
    static let shared = PhotoManager()
    private init() {}
    
    var response: Response = .init(items: [], count: 0)
    var photos = [Photo]()
    
    func fetchPhoto() {
        VK.API.Photos.get([.ownerId: "-128666765",
                           .albumId: "266276915"])
        .onSuccess { data in
            let decodedData = try JSONDecoder().decode(Response.self, from: data)
            self.response = decodedData
            
            DispatchQueue.main.async { [weak self] in
                print(self?.response ?? "No load photos")
            }
        }
        .onError { error in
            print("Error", error)
        }
        .send()
    }
    
    func responseConvertToPhotos(response: Response) {
        
    }
    
}
