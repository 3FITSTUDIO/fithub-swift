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
    
    func authenticateOnLogin(login: String?, passwd: String?) -> Bool {
        if (login != nil && passwd != nil) {
             return login == "a" && passwd == "a"
        }
        guard let login = login, let passwd = passwd, let store = store else { return false }
        return store.authenticatePassword(forUsername: login, inputPasswd: passwd)
    }
    
    //autentykacja
    ///loginu
    ///rejestracji
}
