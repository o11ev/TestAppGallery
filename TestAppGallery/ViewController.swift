//
//  ViewController.swift
//  TestAppGallery
//
//  Created by Olga Dragunova on 27.03.2022.
//

import UIKit

class ViewController: UIViewController {
    
    let apiWorker = APIWorker()
    
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtonAppearance()
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        apiWorker.authorize()
    }

}

extension ViewController {
    private func setupButtonAppearance() {
        loginButton.backgroundColor = .black
        loginButton.layer.cornerRadius = 8
        loginButton.clipsToBounds = true
    }
}

