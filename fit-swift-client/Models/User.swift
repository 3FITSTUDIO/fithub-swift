//
//  User.swift
//  fit-swift-client
//
//  Created by admin on 20/10/2019.
//  Copyright © 2019 Dominik Urbaez Gomez. All rights reserved.
//

import Foundation

struct User : Codable {
    let id: Int
    let firstName: String
    let lastName: String
    let email: String
    var login: String
    var password: String

    init?(id: Int, firstName: String, lastName: String, email: String, login: String, password: String) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.login = login
        self.password = password
    }
}

extension User {
    init(json: [String: Any]) throws {
        guard let id = json["id"] as? Int else {
            throw SerializationError.missing("id")
        }
        
        guard let firstName = json["first_name"] as? String else {
            throw SerializationError.missing("first_name")
        }
        
        guard let lastName = json["last_name"] as? String else {
            throw SerializationError.missing("last_name")
        }
        
        guard let email = json["email"] as? String else {
            throw SerializationError.missing("email")
        }
        
        guard let login = json["login"] as? String else {
            throw SerializationError.missing("login")
        }
        
        guard let password = json["password"] as? String else {
            throw SerializationError.missing("password")
        }

        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.login = login
        self.password = password
    }
}
