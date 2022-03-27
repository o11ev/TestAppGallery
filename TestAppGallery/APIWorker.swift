//
//  APIWorker.swift
//  TestAppGallery
//
//  Created by Olga Dragunova on 27.03.2022.
//

import Foundation
import SwiftyVK

class APIWorker {
    
    func authorize() {
        VK.sessions.default.logIn(
            onSuccess: { info in
                print("SwiftyVK: success authorize with", info)
            },
            onError: { error in
                print("SwiftyVK: authorize failed with", error)
            }
        )
    }
    
    func logout() {
        VK.sessions.default.logOut()
        print("SwiftyVK: LogOut")
    }
    
}
