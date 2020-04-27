//
//  UserStore.swift
//  fit-swift-client
//
//  Created by admin on 12/01/2020.
//  Copyright © 2020 Dominik Urbaez Gomez. All rights reserved.
//

import Foundation

class UserStore {
    public var apiClient: UserNetworking
    public var currentUser: User?
    
    init() {
        apiClient = UserNetworking()
        apiClient.store = self
    }
    
    func clearProfileOnLogout() {
        currentUser = nil
    }
    
    // MARK: Login View Controller, Authentication
    func authenticatePassword(forUsername login: String, inputPasswd passwd: String, onComplete: @escaping(Bool) -> Void) {
        var isAuthenticated = false
        apiClient.getUser(forUsername: login, inputPasswd: passwd) { result in
            switch result {
            case .failure(let error):
                print(error)
                onComplete(false)
            case .success(let user):
                isAuthenticated = user.login == login && user.password == passwd
                if isAuthenticated {
                    self.currentUser = user
                }
                onComplete(isAuthenticated)
            }
        }
    }
    
    // MARK: Sign Up View Controller
    func verifyDataOnSignUp(data: [String?]) -> Bool {
        guard apiClient.postNewAccountCreated(name: data[0], surname: data[1], email: data[2], password: data[3]) else { return false }
        return true
    }
}
