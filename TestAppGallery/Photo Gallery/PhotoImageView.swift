//
//  PhotoCell.swift
//  TestAppGallery
//
//  Created by Olga Dragunova on 28.03.2022.
//

import UIKit

class PhotoImageView: UIImageView {
    
    var activityIndicator: UIActivityIndicatorView!
    
    private var dataTask: URLSessionDataTask?
    
    func showIndicator() {
        activityIndicator =
        UIActivityIndicatorView(frame: CGRect(x: self.superview!.center.x,
                                              y: self.superview!.center.y,
                                              width: 50,
                                              height: 50))
        self.superview!.addSubview(activityIndicator)
        activityIndicator.center = self.superview!.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
    }
    
    
    func setImage(image: UIImage) {
        self.image = image
        activityIndicator.stopAnimating()
    }
    
    func loadImage(from imageUrl: String) {
        
        showIndicator()
        
        guard let url = URL(string: imageUrl) else {
            return print("Не получилось создать URL")
        }
        
        dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return self.clear() }
            if let image = UIImage(data: data) {
                DispatchQueue.main.async() { [weak self] in
                    self?.setImage(image: image)
                }
            }
        }
        
        dataTask?.resume()
    }
        
    func clear() {
        dataTask?.cancel()
        dataTask = nil
    }
}
