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
    private var urlWeights: String = ""
    private var urlCalories: String = ""
    private var urlSteps: String = ""
    
    override init() {
        super.init()
        urlUsers = urlBase + "/users"
        urlPasswords = urlBase + "/passwords"
        urlWeights = urlBase + "/weights"
        urlCalories = urlBase + "/weights"
        urlSteps = urlBase + "/steps"
        
        stubWeightArray()
        stubCaloriesArray()
    }
    
    // MARK: Login View Controller, Authentication
    func authenticatePassword(forUsername login: String, inputPasswd: String) -> Bool {
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
    
    func fetchUserData(byId id: Int) -> User? {
        
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
    
    // MARK: Sign Up View Controller
    func postNewAccountCreated(name: String?, surname: String?, email: String?, password: String?) -> Bool {
        guard name != nil && surname != nil && email != nil && password != nil else { return false }
        
        let url = urlUsers
        var params: [String: Any] = [:]
        params["name"] = name
        params["surname"] = surname
        params["email"] = email
        params["password"] = password
        
        var success = false
        executeRequest(url, .post, parameters: params) { (json, error) in
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
        
        let url = urlWeights + "/" + String(id)
        var record: Record?
        var records = [Record]()
        
        executeRequest(url, .get) { (json, error) in
            if let error = error {
                debugPrint(error.localizedDescription)
                debugPrint("fetch_user_data: Received error from server")
            }
            else if let json = json {
                do {
                    try json.forEach {
                        record = try Record(json: $0)
                        if let recordUnwrapped = record {
                            records.append(recordUnwrapped)
                        }
                    }
                } catch {
                    debugPrint("fetch_user_data: Failed to deserialize incoming data")
                }
            }
        }
        return records
    }
    
    func fetchCaloriesData(forUserId id: Int) -> [Record] {
        return caloriesArray // STUB FOR TESTING
        
        let url = urlCalories + "/" + String(id)
        var record: Record?
        var records = [Record]()
        
        executeRequest(url, .get) { (json, error) in
            if let error = error {
                debugPrint(error.localizedDescription)
                debugPrint("fetch_user_data: Received error from server")
            }
            else if let json = json {
                do {
                    try json.forEach {
                        record = try Record(json: $0)
                        if let recordUnwrapped = record {
                            records.append(recordUnwrapped)
                        }
                    }
                } catch {
                    debugPrint("fetch_user_data: Failed to deserialize incoming data")
                }
            }
        }
        return records
    }
    
    // MARK: Post steps data
    
    func postStepsData(steps: Int, date: Date) -> Bool {
        let url = urlSteps
        var params: [String: Any] = [:]
        params["value"] = steps
        params["date"] = FitHubDateFormatter.formatDate(date)
        
        var success = false
        executeRequest(url, .post, parameters: params) { (json, error) in
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
    
    // MARK: Add New Value View Controller
    func postNewWeightsRecord(value: Int, date: Date) -> Bool {
        
        store?.weightData.append(Record(id: 1, value: [value], date: FitHubDateFormatter.formatDate(date)))
        return true
        
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
    }
    
    func postNewCaloriesRecord(value: Int, date: Date) -> Bool {
        
        store?.caloriesData.append(Record(id: 1, value: [value], date: FitHubDateFormatter.formatDate(date)))
        return true
//
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
    }
    
    // MARK: STUBS
    var weightArray = [Record]()
    private func stubWeightArray() {
        for i in 1...31 {
            let randWeight = Int.random(in: 95...99)
            weightArray.append(Record(id: i, value: [randWeight], date: FitHubDateFormatter.formatDate(Date.distantPast)))
        }
    }
    var caloriesArray = [Record]()
    private func stubCaloriesArray() {
        for i in 1...31 {
            let randWeight = Int.random(in: 2300...3000)
            caloriesArray.append(Record(id: i, value: [randWeight], date: FitHubDateFormatter.formatDate(Date.distantPast)))
        }
    }
}
