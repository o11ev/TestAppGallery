//
//  ViewController.swift
//  TestAppGallery
//
//  Created by Olga Dragunova on 27.03.2022.
//

import UIKit
import SwiftyVK

class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginButton: UIButton!
    
    var response: Response = .init(items: [], count: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtonAppearance()
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        authorize()
    }
    
    private func setupButtonAppearance() {
        loginButton.backgroundColor = .black
        loginButton.layer.cornerRadius = 8
        loginButton.clipsToBounds = true
    }
    
    private func authorize() {
        VK.sessions.default.logIn(
            onSuccess: { info in
                print("SwiftyVK: success authorize with", info)
                self.loadPhotos()
                
                DispatchQueue.main.async { [weak self] in
                    self?.goToPhotoGallery()
                }
            },
            onError: { error in
                print("SwiftyVK: authorize failed with", error)
            }
        )
    }
    
    private func loadPhotos() {
        VK.API.Photos.get([.ownerId: "-128666765",
                           .albumId: "266276915"])
        .onSuccess { data in
            let json = try JSONDecoder().decode(Response.self, from: data)
            self.response = json
            
            DispatchQueue.main.async { [weak self] in
                print(self?.response ?? "no load photos")
            }
        }
        .onError { error in
            print("error", error)
        }
        .send()
    }
    
    private func goToPhotoGallery() {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        
        let photoGalleryVC = storyboard.instantiateViewController(withIdentifier: "NavigationVC") as! NavigationViewController
        
        present(photoGalleryVC, animated: true)
    }
}
