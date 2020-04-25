//
//  UserNetworking.swift
//  fit-swift-client
//
//  Created by admin on 25/12/2019.
//  Copyright © 2019 Dominik Urbaez Gomez. All rights reserved.
//

import Foundation

enum UserError: Error {
    case dataNotAvailable
    case cannotProcessData
}

class UserNetworking : NetworkingClient {
    
    weak var store: UserStore?
    private var userEndpoint = "/user"
    
    override init() {
        super.init()
        stubWeightArray()
        stubCaloriesArray()
    }
    
    // MARK: Login View Controller, Authentication
    func getUser(forUsername login: String, inputPasswd: String, onComplete: @escaping(Result<User, UserError>) -> Void) {
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
    
    func fetchUserData(byId id: Int, onComplete: @escaping(Result<User, UserError>) -> Void) {
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
    
    // MARK: Dashboard View Controller, Fetching all data
    func fetchWeightData(forUserId id: Int) -> [Record] {
        return weightArray // STUB FOR TESTING
        
//        let url = urlWeights + "/" + String(id)
//        var record: Record?
//        var records = [Record]()
//
//        executeRequest(url, .get) { (json, error) in
//            if let error = error {
//                debugPrint(error.localizedDescription)
//                debugPrint("fetch_user_data: Received error from server")
//            }
//            else if let json = json {
//                do {
//                    try json.forEach {
//                        record = try Record(json: $0)
//                        if let recordUnwrapped = record {
//                            records.append(recordUnwrapped)
//                        }
//                    }
//                } catch {
//                    debugPrint("fetch_user_data: Failed to deserialize incoming data")
//                }
//            }
//        }
//        return records
    }
    
    func fetchCaloriesData(forUserId id: Int) -> [Record] {
        return caloriesArray // STUB FOR TESTING
        
//        let url = urlCalories + "/" + String(id)
//        var record: Record?
//        var records = [Record]()
//
//        executeRequest(url, .get) { (json, error) in
//            if let error = error {
//                debugPrint(error.localizedDescription)
//                debugPrint("fetch_user_data: Received error from server")
//            }
//            else if let json = json {
//                do {
//                    try json.forEach {
//                        record = try Record(json: $0)
//                        if let recordUnwrapped = record {
//                            records.append(recordUnwrapped)
//                        }
//                    }
//                } catch {
//                    debugPrint("fetch_user_data: Failed to deserialize incoming data")
//                }
//            }
//        }
//        return records
    }
    
    // MARK: Post steps data
    
//    func postStepsData(steps: Int, date: Date) -> Bool {
//        let url = urlSteps
//        var params: [String: Any] = [:]
//        params["value"] = steps
//        params["date"] = FitHubDateFormatter.formatDate(date)
//
//        var success = false
//        executeRequest(url, .post, parameters: params) { (json, error) in
//            if let error = error {
//                debugPrint(error.localizedDescription)
//                debugPrint("fetch_user_id: Received error from server")
//            }
//            else {
//                success = true
//            }
//        }
//        return success
//    }
    
    // MARK: Add New Value View Controller
    
//    func postNewWeightsRecord(value: Int, date: Date) -> Bool {
//        let url = urlWeights
//        var params: [String: Any] = [:]
//        params["value"] = value
//        params["date"] = FitHubDateFormatter.formatDate(date)
//
//        var success = false
//        executeRequest(url, .post, parameters: params) { (json, error) in
//            if let error = error {
//                debugPrint(error.localizedDescription)
//                debugPrint("fetch_user_id: Received error from server")
//            }
//            else {
//                success = true
//            }
//        }
//        return success
//    }
    
//    func postNewCaloriesRecord(value: Int, date: Date) -> Bool {
//        let url = urlCalories
//        var params: [String: Any] = [:]
//        params["value"] = value
//        params["date"] = FitHubDateFormatter.formatDate(date)
//
//        var success = false
//        executeRequest(url, .post, parameters: params) { (json, error) in
//            if let error = error {
//                debugPrint(error.localizedDescription)
//                debugPrint("fetch_user_id: Received error from server")
//            }
//            else {
//                success = true
//            }
//        }
//        return success
//    }
    
    // MARK: STUBS
    var weightArray = [Record]()
    private func stubWeightArray() {
        for i in 1...31 {
            let randWeight = Int.random(in: 95...99)
            weightArray.append(Record(id: i, value: randWeight, date: FitHubDateFormatter.formatDate(Date.distantPast)))
        }
    }
    var caloriesArray = [Record]()
    private func stubCaloriesArray() {
        for i in 1...31 {
            let randWeight = Int.random(in: 2300...3000)
            caloriesArray.append(Record(id: i, value: randWeight, date: FitHubDateFormatter.formatDate(Date.distantPast)))
        }
    }
}
