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
                vc?.displayAlert(success: false)
                return
            }
        }
        // passwords matching
        guard data[4] == data[5] else {
            vc?.displayAlert(success: false)
            return
        }
        if let store = store {
            store.verifyDataOnSignUp(data: data) { result in
                self.vc?.displayAlert(success: result)
                return
            }
        }
        return
    }
}
