//
//  UserNetworking.swift
//  fit-swift-client
//
//  Created by admin on 25/12/2019.
//  Copyright © 2019 Dominik Urbaez Gomez. All rights reserved.
//

import Foundation

class UserNetworking : NetworkingClient {
    
    weak var store: UserStore?
    
    private var urlUsers: String = ""
    private var urlPasswords: String = ""
    
    override init() {
        super.init()
        urlUsers = urlBase + "/users"
        urlPasswords = urlBase + "/passwords"
    }
    
    public func authenticatePassword(forUsername login: String, inputPasswd: String) -> Bool {
        let url = urlPasswords + "/" + login
        var isSuccessful = false
        
        var params: [String: Any] = [:]
        guard let id = fetchUserId(forLogin: login) else { return false }
        params["id"] = id
        params["password"] = inputPasswd
        
        executeRequest(url, .get, parameters: params) { (json, error) in
            if let error = error {
                debugPrint(error.localizedDescription)
            }
            else {
                isSuccessful = true
            }
        }
        if isSuccessful {
            store?.currentUser = fetchUserData(byId: id)
        }
        return isSuccessful
    }
    
    private func fetchUserId(forLogin login: String) -> Int? {
        let url = urlUsers
        var user: User?
        var params: [String: Any] = [:]
        params["login"] = login
        
        executeRequest(url, .get, parameters: params) { (json, error) in
            if let error = error {
                debugPrint(error.localizedDescription)
                debugPrint("fetch_user_id: Received error from server")
            }
            else if let json = json {
                do {
                    user = try User(json: json[0])
                } catch {
                    debugPrint("fetch_user_id: Failed to deserialize incoming data")
                }
            }
        }
        return user?.id
    }
    
    public func fetchUserData(byId id: Int) -> User? {
        
        let url = urlUsers + "/" + String(id)
        var user: User?
        
        executeRequest(url, .get) { (json, error) in
            if let error = error {
                debugPrint(error.localizedDescription)
                debugPrint("fetch_user_data: Received error from server")
            }
            else if let json = json {
                do {
                    user = try User(json: json[0])
                } catch {
                    debugPrint("fetch_user_data: Failed to deserialize incoming data")
                }
            }
        }
        return user
    }
}
