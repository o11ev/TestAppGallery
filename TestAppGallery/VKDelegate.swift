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
    let scopes: Scopes = [.offline,.photos]
    
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
    
    func vkTokenCreated(for sessionId: String, info: [String : String]) {
        print("token created in session \(sessionId) with info \(info)")
    }
    
    func vkTokenUpdated(for sessionId: String, info: [String : String]) {
        print("token updated in session \(sessionId) with info \(info)")
    }
    
    func vkTokenRemoved(for sessionId: String) {
        print("token removed in session \(sessionId)")
    }
}
