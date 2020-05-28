//
//  UserStore.swift
//  fit-swift-client
//
//  Created by admin on 12/01/2020.
//  Copyright © 2020 Dominik Urbaez Gomez. All rights reserved.
//

import Foundation

class UserStore {
    private var apiClient: UserNetworking
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
        apiClient.getUser(forUsername: login, inputPasswd: passwd) { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
                onComplete(false)
            case .success(let user):
                self?.currentUser = user
                onComplete(true)
            }
        }
    }
    
    // MARK: Sign Up View Controller
    func tryCreateNewUser(data: [String?], onComplete: @escaping(Bool) -> Void) {
        apiClient.postNewAccountCreated(name: data[0], surname: data[1], email: data[2], login: data[3], password: data[4], sex: data[6], height: data[7], yearOfBirth: data[8]) { [weak self] result in
            self?.authenticatePassword(forUsername: data[3]!, inputPasswd: data[4]!) { _ in
                onComplete(result)
            }
        }
    }
}
