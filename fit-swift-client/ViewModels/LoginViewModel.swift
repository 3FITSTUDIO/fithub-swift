//
//  LoginViewModel.swift
//  fit-swift-client
//
//  Created by admin on 05/11/2019.
//  Copyright © 2019 Dominik Urbaez Gomez. All rights reserved.
//

import Foundation

class LoginViewModel {
    
    private weak var vc: LoginViewController?
    
    func authenticate(login: String?, passwd: String?) -> Bool {
        if (login != nil && passwd != nil) {
             return login == "a" && passwd == "a"
        }
        return false
    }
}
