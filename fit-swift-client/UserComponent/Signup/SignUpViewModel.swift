//
//  SignUpViewModel.swift
//  fit-swift-client
//
//  Created by admin on 06/11/2019.
//  Copyright © 2019 Dominik Urbaez Gomez. All rights reserved.
//

import Foundation

class SignUpViewModel {
    private var store: UserStore?
    weak var vc: SignUpViewController?
    
    init() {
        store = mainStore.userStore
    }
    
    func verifyEnteredData(data: [String?]) {
        // no empty data
        data.forEach {
            guard $0 != "" else {
                vc?.displayAlert(type: .emptyFields)
                return
            }
        }
        // passwords matching
        if let passwd = data[4]{
            guard Validation.validatePassword(password: passwd) else {
                vc?.displayAlert(type: .invalidPassword)
                return
            }
        }
        else {
            vc?.displayAlert(type: .emptyFields)
            return
        }
        
        guard data[4] == data[5] else {
            vc?.displayAlert(type: .passwordsDontMatch)
            return
        }
        if let store = store {
            store.verifyDataOnSignUp(data: data) { result in
                self.vc?.displayAlert(type: .success)
                return
            }
        }
        return
    }
}
