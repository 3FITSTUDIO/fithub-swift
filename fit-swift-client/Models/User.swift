//
//  User.swift
//  fit-swift-client
//
//  Created by admin on 20/10/2019.
//  Copyright © 2019 Dominik Urbaez Gomez. All rights reserved.
//

import Foundation

class User {
    let id: Int // TODO: Implement receiving all property contents from API
    var login: String
    let email: String
    let name: String
    let surname: String
    let accountType: AccountType
    
    init?(id: Int, login: String, email: String, name: String, surname: String, accountType: AccountType) {
//        guard verifyLoginEmail(email: email) else { return nil }
        self.id = id
        self.login = login
        self.email = email
        self.name = name
        self.surname = surname
        self.accountType = accountType
    }
    
    fileprivate func verifyLoginEmail(login: String, email: String) -> Bool {
        //Implement veryfing login and email format
        return false
    }
    
    fileprivate func verifyNameSurname(name: String, surname: String) -> Bool {
        //Implement veryging name and surname format
        return false
    }
    
    fileprivate func verifyUserContents(login: String, email: String, name: String, surname: String) -> Bool {
        guard verifyLoginEmail(login: login, email: email), verifyNameSurname(name: name, surname: surname) else { return false }
        return true
    }
}
