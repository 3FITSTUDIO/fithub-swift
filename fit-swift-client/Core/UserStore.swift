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
    
    // MARK: Login View Controller, Authentication
    func authenticatePassword(forUsername login: String, inputPasswd passwd: String) -> Bool {
        return apiClient.authenticatePassword(forUsername: login, inputPasswd: passwd)
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
    
    func postNewWeightsRecord(value: Int, date: Date) -> Bool {
        let success = apiClient.postNewWeightsRecord(value: value, date: date)
        fetchWeightData()
        return success
    }
    
    func postNewCaloriesRecord(value: Int, date: Date) -> Bool {
        let success = apiClient.postNewCaloriesRecord(value: value, date: date)
        fetchCaloriesData()
        return success
    }
    
    func postStepsData(_ steps: Int) -> Bool {
        let date = Date()
        let success = apiClient.postStepsData(steps: steps, date: date)
        return success
    }
    
    func clearProfileOnLogout() {
        currentUser = nil
        weightData = [Record]()
        caloriesData = [Record]()
    }
}
