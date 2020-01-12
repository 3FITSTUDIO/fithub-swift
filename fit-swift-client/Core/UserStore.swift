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
    
    //autentykacja
    ///loginu
    ///rejestracji
}
