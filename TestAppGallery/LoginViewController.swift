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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtonAppearance()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        if VK.sessions.default.accessToken != nil {
            goToPhotoGallery()
        }
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
        if VK.sessions.default.accessToken == nil {
        VK.sessions.default.logIn(
            onSuccess: { info in
                print("SwiftyVK: success authorize with", info)
                
                DispatchQueue.main.async { [weak self] in
                    self?.goToPhotoGallery()
                }
            },
            onError: { error in
                print("SwiftyVK: authorize failed with", error)
            }
        )
        }
    }
    
    private func goToPhotoGallery() {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        
        let photoGalleryVC = storyboard.instantiateViewController(withIdentifier: "NavigationVC") as! NavigationViewController
        
        photoGalleryVC.modalPresentationStyle = .fullScreen
        
        present(photoGalleryVC, animated: true)
    }
}
