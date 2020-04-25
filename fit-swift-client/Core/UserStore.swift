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
    
    public var weightData = [Record]()
    public var caloriesData = [Record]()
    
    weak var weightsViewModel: WeightsViewModel?
    weak var caloriesViewModel: CaloriesViewModel?
    
    init() {
        apiClient = UserNetworking()
        apiClient.store = self
    }
    
    func updateDataInViewModels() {
        weightsViewModel?.updateData()
        caloriesViewModel?.updateData()
    }
    
    func clearProfileOnLogout() {
        currentUser = nil
        weightData = [Record]()
        caloriesData = [Record]()
    }
    
    // MARK: Login View Controller, Authentication
    func authenticatePassword(forUsername login: String, inputPasswd passwd: String) -> Bool {
        var isAuthenticated = false
        let semaphore = DispatchSemaphore(value: 0)
        apiClient.getUser(forUsername: login, inputPasswd: passwd) { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let user):
                isAuthenticated = user.login == login && user.password == passwd
            }
            semaphore.signal()
        }
        semaphore.wait()
        return isAuthenticated
    }
    
    // MARK: Sign Up View Controller
    func verifyDataOnSignUp(data: [String?]) -> Bool {
        guard apiClient.postNewAccountCreated(name: data[0], surname: data[1], email: data[2], password: data[3]) else { return false }
        return true
    }
    
    // MARK: Dashboard View Controller, Fetching all data, Posting steps data
    func fetchWeightData() {
//        guard let id = currentUser?.id else { return }
        let id = 1
        let fetchedData = apiClient.fetchWeightData(forUserId: id)
        self.weightData = fetchedData
    }
    
    func fetchCaloriesData() {
//        guard let id = currentUser?.id else { return }
        let id = 1
        let fetchedData = apiClient.fetchCaloriesData(forUserId: id)
        self.caloriesData = fetchedData
    }
}
