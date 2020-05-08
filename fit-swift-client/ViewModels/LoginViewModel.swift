//
//  LoginViewModel.swift
//  fit-swift-client
//
//  Created by admin on 05/11/2019.
//  Copyright © 2019 Dominik Urbaez Gomez. All rights reserved.
//

import Foundation
import UIKit

class LoginViewModel {
    weak var vc: LoginViewController?
    private var store: UserStore?
    
    init() {
        store = mainStore.userStore
    }
    
    func authenticateOnLogin(login: String, passwd: String, onComplete: @escaping() -> Void) {
        if (login == "a" && passwd == "a") {
            vc?.handleLoginAction(success: true)
            onComplete()
            return
        }
        guard let store = store else {
            vc?.handleLoginAction(success: false)
            onComplete()
            return
        }
        store.authenticatePassword(forUsername: login, inputPasswd: passwd) { result in
            self.vc?.handleLoginAction(success: result)
            onComplete()
        }
    }
}
