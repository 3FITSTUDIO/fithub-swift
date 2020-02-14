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
    
    init() {
        store = mainStore.userStore
    }
    
    func verifyEnteredData(data: [String?]) -> Bool {
        if let store = store {
            return store.verifyDataOnSignUp(data: data)
        }
        return false
    }
}
