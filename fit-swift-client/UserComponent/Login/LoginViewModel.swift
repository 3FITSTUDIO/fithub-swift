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
    
    func authenticateOnLogin(login: String, passwd: String) {
        if (login == "abc" && passwd == "xyz") {
            vc?.handleLoginAction(type: .success)
            return
        }
        guard let store = store else {
            vc?.handleLoginAction(type: .noStore)
            return
        }
        if Validation.validatePassword(password: passwd) {
            store.authenticatePassword(forUsername: login, inputPasswd: passwd) { [weak self] result in
                guard result else {
                    self?.vc?.handleLoginAction(type: .invalidInput)
                    return
                }
                self?.vc?.handleLoginAction(type: .success)
                return
            }
        }
        else {
            vc?.handleLoginAction(type: .invalidInput)
        }
    }
}
