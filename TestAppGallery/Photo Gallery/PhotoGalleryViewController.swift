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
    
    
    func loadAlbum() {
        VK.API.Photos.get([.ownerId: "-128666765",
                           .albumId: "266276915"])
        .onSuccess { [self] json in
            self.albumData = try JSONDecoder().decode(Response.self, from: json)
            print("фотки загружены в количестве \(albumData.count) штук")
            
            DispatchQueue.main.async { [weak self] in
                self?.photoCollectionView.reloadData()
            }
        }
        .onError { error in
            //TODO: Обработать ошибку
            
//            DispatchQueue.main.async { [weak self] in
             //TODO: Обработать ошибку
//            }
            print("Error", error)
        }
        .send()
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let image = UIImage(named: "chevron.backward")
        let backItem = UIBarButtonItem(image: image, style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backItem
        navigationItem.backBarButtonItem?.tintColor = .black
        
        if segue.identifier == "pickPhotoSegue" {
            let photoVC = segue.destination as! PhotoViewController
            let cell = sender as! PhotoCell
            photoVC.image = cell.photoImageView.image!
        }
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("Photo count: \(albumData.count)")
 
        return albumData.count
    }

    // возвращает ячейку
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PhotoCell
        
        let imageUrl = albumData.items[indexPath.row].sizes.first {$0.type == "y"}?.url

        if let unwrapedImageUrl = imageUrl {
            cell.loadImage(from: unwrapedImageUrl)
        }
        
        return cell
    }
    
    // MARK: Log Out Button
    
    @IBAction func logOutButton(_ sender: UIBarButtonItem) {
        VK.sessions.default.logOut()
        self.dismiss(animated: true)
    }
    
}

    // MARK: Set up photo grid
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

