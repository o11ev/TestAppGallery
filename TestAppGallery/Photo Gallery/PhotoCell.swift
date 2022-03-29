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
}
