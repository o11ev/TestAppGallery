//
//  PhotoViewController.swift
//  TestAppGallery
//
//  Created by Olga Dragunova on 28.03.2022.
//

import UIKit

class PhotoViewController: UIViewController {
    
    var image = UIImage()
    
    @IBOutlet weak var photoImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        photoImageView.image = image
    }

    
    @IBAction func exportButton(_ sender: UIBarButtonItem) {
        
        guard let imageToShare = photoImageView.image else { return }
        
        let shareController = UIActivityViewController(activityItems: [imageToShare], applicationActivities: nil)
        
        shareController.completionWithItemsHandler = { _, bool, _, _ in
            if bool {
                print("Успешно")
            }
        }
        
        present(shareController, animated: true, completion: nil )
        
    }
    
    
}
