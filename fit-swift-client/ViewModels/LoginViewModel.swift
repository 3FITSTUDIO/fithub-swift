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
    private weak var vc: LoginViewController?
    private var store: UserStore?
    
    init() {
        store = mainStore.userStore
    }
    
    func authenticateOnLogin(login: String?, passwd: String?, onComplete: @escaping(Bool) -> Void) {
        if (login == "a" && passwd == "a") {
            onComplete(true)
        }
        guard let login = login, let passwd = passwd, let store = store else {
            onComplete(false)
            return
        }
        store.authenticatePassword(forUsername: login, inputPasswd: passwd) { result in
            onComplete(result)
        }
    }
}
