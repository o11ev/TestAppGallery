//
//  PhotoCell.swift
//  TestAppGallery
//
//  Created by Olga Dragunova on 28.03.2022.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    func loadImage(image: UIImage) {
        photoImageView.image = image
        activityIndicator.stopAnimating()
    }
    
    func loadImage(from imageUrl: String) {
        
        let url = URL(string: imageUrl)

        URLSession.shared.dataTask(with: url!) { (data, respones, error) in
    
            if error != nil {
                //TODO: Обработать ошибку
                return
            }
            
            DispatchQueue.main.async {
                guard let image = UIImage(data: data!) else {
                    return
                }
                print("картинка загрузилась успешно")
                print(image.size)
                self.loadImage(image: image)
            }
        }
        .resume()
    }
}
