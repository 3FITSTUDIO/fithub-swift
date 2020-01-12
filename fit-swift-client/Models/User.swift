//
//  User.swift
//  fit-swift-client
//
//  Created by admin on 20/10/2019.
//  Copyright © 2019 Dominik Urbaez Gomez. All rights reserved.
//

import Foundation

struct User : Codable {
    let id: Int // TODO: Implement receiving all property contents from API
    var login: String
    let email: String
    let name: String
    let surname: String
//    let accountType: AccountType

    init?(id: Int, login: String, email: String, name: String, surname: String) {
        self.id = id
        self.login = login
        self.email = email
        self.name = name
        self.surname = surname
//        self.accountType = accountType
        guard verifyUserContents(login: login, email: email, name: name, surname: surname) else { return nil }
    }
    
    fileprivate func verifyUserContents(login: String, email: String, name: String, surname: String) -> Bool {
        guard verifyLoginEmail(login: login, email: email), verifyNameSurname(name: name, surname: surname) else { return false }
        guard verifyNameSurname(name: name, surname: surname) else { return false }
        return true
    }
    
    fileprivate func verifyLoginEmail(login: String, email: String) -> Bool {
        //Implement veryfing login and email format
        guard login.range(of: #"[a-zA-Z][._-][a-zA-z0-9]"#, options: .regularExpression) != nil else { return false }
        guard email.range(of: #"[A-Za-z]+_[0-9]@[a-z]+.[a-z]+"#, options: .regularExpression) != nil else { return false }
        return true
    }
    
    fileprivate func verifyNameSurname(name: String, surname: String) -> Bool {
        guard name.range(of: #"[A-z]+[a-zA-Z]*"#, options: .regularExpression) != nil else { return false }
        guard surname.range(of: #"[A-z]+[a-zA-Z]*"#, options: .regularExpression) != nil else { return false }
        return true
    }
}

extension User {
    init(json: [String: Any]) throws {
        guard let id = json["id"] as? Int else {
            throw SerializationError.missing("id")
        }
        
        guard let login = json["login"] as? String else {
            throw SerializationError.missing("login")
        }
        
        guard let email = json["email"] as? String else {
            throw SerializationError.missing("email")
        }
        
        guard let name = json["name"] as? String else {
            throw SerializationError.missing("name")
        }
        
        guard let surname = json["surname"] as? String else {
            throw SerializationError.missing("surname")
        }
        
        self.id = id
        self.login = login
        self.email = email
        self.name = name
        self.surname = surname
    }
    
}
