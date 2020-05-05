//
//  UserNetworking.swift
//  fit-swift-client
//
//  Created by admin on 25/12/2019.
//  Copyright © 2019 Dominik Urbaez Gomez. All rights reserved.
//

import Foundation

final class UserNetworking : NetworkingClient {
    
    weak var store: UserStore?
    private var userEndpoint = "/user"
    
    // MARK: Login View Controller, Authentication
    func getUser(forUsername login: String, inputPasswd: String, onComplete: @escaping(Result<User, NetworkError>) -> Void) {
        var params = [String: Any]()
        params["login"] = login
        params["password"] = inputPasswd
        
        executeRequest(userEndpoint, .get, parameters: params) { (json, error) in
            if let error = error {
                debugPrint(error.localizedDescription)
                onComplete(.failure(.dataNotAvailable))
                return
            }
            else if let jsonData = json?.first {
                do {
                    let user = try User(json: jsonData)
                    onComplete(.success(user))
                    return
                } catch {
                    debugPrint("fetch_user_data: Failed to deserialize incoming data")
                    onComplete(.failure(.cannotProcessData))
                    return
                }
            }
        }
    }
    
    func fetchUserData(byId id: Int, onComplete: @escaping(Result<User, NetworkError>) -> Void) {
        let endpoint = userEndpoint + "/" + String(id)
        
        executeRequest(endpoint, .get) { (json, error) in
            if let error = error {
                debugPrint("fetch_user_data: Received error from server: \n" + error.localizedDescription)
                onComplete(.failure(.dataNotAvailable))
            }
            else if let json = json {
                do {
                    let user = try User(json: json[0])
                    onComplete(.success(user))
                } catch {
                    debugPrint("fetch_user_data: Failed to deserialize incoming data")
                    onComplete(.failure(.cannotProcessData))
                }
            }
        }
    }
    
    // MARK: Sign Up View Controller
    func postNewAccountCreated(name: String?, surname: String?, email: String?, password: String?) -> Bool {
        guard name != nil && surname != nil && email != nil && password != nil else { return false }
        
        var params: [String: Any] = [:]
        params["first_name"] = name
        params["last_name"] = surname
        params["email"] = email
        //        params["login"] = login // DODAC LOGIN
        params["password"] = password
        
        var success = false
        executeRequest(userEndpoint, .post, parameters: params) { (json, error) in
            if let error = error {
                debugPrint(error.localizedDescription)
                debugPrint("fetch_user_id: Received error from server")
            }
            else {
                success = true
            }
        }
        return success
    }
}
