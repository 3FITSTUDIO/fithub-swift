//
//  UserNetworking.swift
//  fit-swift-client
//
//  Created by admin on 25/12/2019.
//  Copyright © 2019 Dominik Urbaez Gomez. All rights reserved.
//

import Foundation

class UserNetworking : NetworkingClient {
    static func authenticateUserCredentials() -> Bool {
        let url = "https://api.com/users"
        var hasErrorOccured = true
        
//        executeJSONRequest(url, .get) { (json, error) in
//            if let error = error {
//                debugPrint(error.localizedDescription)
//            }
//            else if let usersJSON = json {
//                hasErrorOccured = false
//                do {
//                    guard let json = try JSONSerialization.jsonObject(with: usersJSON, options: .mutableContainers) as? [String: Any] else { return }
//                    let users =
//                }
//            }
//        }
        
        return false
    }
}
