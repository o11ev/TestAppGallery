//
//  PhotoViewController.swift
//  TestAppGallery
//
//  Created by Olga Dragunova on 28.03.2022.
//

import UIKit

class PhotoViewController: UIViewController {
    
    @IBOutlet weak var photoImageView: PhotoImageView!

    var imageUrl: String = ""
    var imageDateUTS: Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photoImageView.loadImage(from: imageUrl)
        self.title = getDate(date: imageDateUTS) ?? "No date"
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
    
    private func getDate(date: Double?) -> String? {
        if let unwrapedDate = date {
            let unwrapedDate = Date(timeIntervalSince1970: unwrapedDate)
            let formater = DateFormatter()
            formater.dateFormat = "dd MMMM YYYY"
            return formater.string(from: unwrapedDate)
        }
        return nil
    }
}
