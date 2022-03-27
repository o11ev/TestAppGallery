//
//  VKDelegate.swift
//  TestAppGallery
//
//  Created by Olga Dragunova on 27.03.2022.
//

import Foundation
import SwiftyVK

class VKDelegate: SwiftyVKDelegate {
    
    let appID = "8117674"
    let scopes: Scopes = [.messages,.offline,.friends,.wall,.photos,.audio,.video,.docs,.market,.email]
    
    init() {
        VK.setUp(appId: appID, delegate: self)
    }
    
    
    func vkNeedsScopes(for sessionId: String) -> Scopes {
        return scopes
    }
    
    func vkNeedToPresent(viewController: VKViewController) {
        if let rootController = UIApplication.shared.keyWindow?.rootViewController {
            rootController.present(viewController, animated: true)
        }
    }
    
    
}
