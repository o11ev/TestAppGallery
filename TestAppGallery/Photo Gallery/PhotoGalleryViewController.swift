//
//  PhotosCollectionViewController.swift
//  TestAppGallery
//
//  Created by Olga Dragunova on 27.03.2022.
//

import UIKit
import SwiftyVK

class PhotoGalleryViewController: UICollectionViewController {
    
    @IBOutlet var photoCollectionView: UICollectionView!
    
    var albumData: Response = .init(items: [], count: 0)
    
    private let reuseIdentifier = "photoCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadAlbum()
    }
    
    // MARK: - Set up next screen
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let imageUrl = albumData.items[indexPath.row].sizes.first {$0.type == "y"}?.url
        let imageDate = albumData.items[indexPath.row].date
        
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let photoVC = storyboard.instantiateViewController(identifier: "DetailedPhotoVC") as! PhotoViewController
        
        setUpBar()
        
        if let unwrapedImageUrl = imageUrl {
            photoVC.imageUrl = unwrapedImageUrl
            photoVC.imageDateUTS = Double(imageDate)
        }
        
        navigationController?.pushViewController(photoVC, animated: true)
    }

    // MARK: - UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("Photo count: \(albumData.count)")
        return albumData.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! GalleryCollectionViewCell
        
        let imageUrl = albumData.items[indexPath.row].sizes.first {$0.type == "y"}?.url

        if let unwrapedImageUrl = imageUrl {
            cell.photoImageView.loadImage(from: unwrapedImageUrl)
        }
        return cell
    }
    
    // MARK: - Log out button
    @IBAction func logOutButton(_ sender: UIBarButtonItem) {
        VK.sessions.default.logOut()
        self.dismiss(animated: true)
    }
    
    // MARK: - Load data from VK
    private func loadAlbum() {
        VK.API.Photos.get([.ownerId: "-128666765",
                           .albumId: "266276915"])
        .onSuccess { [self] json in
            self.albumData = try JSONDecoder().decode(Response.self, from: json)
            
            DispatchQueue.main.async { [weak self] in
                self?.photoCollectionView.reloadData()
            }
        }
        .onError {error in
            
            DispatchQueue.main.async { [weak self] in
                self?.showAlert(title: "Ошибка загрузки фото",
                          message: "\(error)")
            }
            print("Error", error)
        }
        .send()
    }
    
    // MARK: - Set up tab bar in next screen
    private func setUpBar() {
        let image = UIImage(named: "chevron.backward")
        let backItem = UIBarButtonItem(image: image, style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backItem
        navigationItem.backBarButtonItem?.tintColor = .black
    }
}

// MARK: - Set up photo grid
extension PhotoGalleryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width / 2 - 1
        let height = UIScreen.main.bounds.width / 2
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat{
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat{
        return 2
    }
}

// MARK: - Alert Controller
extension PhotoGalleryViewController {
    private func showAlert(title: String,message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}
