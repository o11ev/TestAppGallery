//
//  GalleryCollectionViewCell.swift
//  TestAppGallery
//
//  Created by Olga Dragunova on 01.04.2022.
//

import Foundation
import UIKit

class GalleryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var photoImageView: PhotoImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        photoImageView.clear()
    }
}
