//
//  DataStore.swift
//  fit-swift-client
//
//  Created by admin on 25/04/2020.
//  Copyright © 2020 Dominik Urbaez Gomez. All rights reserved.
//

import Foundation

class DataStore {
    public var apiClient: DataNetworking
    
    public var weightData = [Record]()
    public var caloriesData = [Record]()
    
    weak var weightsViewModel: WeightsViewModel?
    weak var caloriesViewModel: CaloriesViewModel?
    
    private var currentlyStoredData = [String: Any]()
    
    init() {
        apiClient = DataNetworking()
        apiClient.store = self
        initializeCurrentlyStoredData()
    }
    
    private func currentUser() -> User? {
        return mainStore.userStore.currentUser
    }
    
    private func authenticateUserProfile() -> User? {
        guard let user = currentUser() else {
            debugPrint("USER_ERROR: Failed to authenticate user profile.")
            return nil
        }
        return user
    }
    
    func clearDataOnLogout() {
        weightData = [Record]()
        caloriesData = [Record]()
    }
    
    func updateDataInViewModels() {
        weightsViewModel?.updateData()
        caloriesViewModel?.updateData()
    }
    
    private func initializeCurrentlyStoredData() {
        currentlyStoredData["stepsCount"] = 0
    }
    
    // MARK: Dashboard View Controller, Fetching all data, Posting steps data
    func fetchWeightData() {
        guard let user = authenticateUserProfile() else { return }
        let fetchedData = apiClient.fetchWeightData(forUserId: user.id)
        self.weightData = fetchedData
    }
    
    func fetchCaloriesData() {
        guard let user = authenticateUserProfile() else { return }
        let fetchedData = apiClient.fetchCaloriesData(forUserId: user.id)
        self.caloriesData = fetchedData
    }
    
    func postStepsData(_ steps: Int, onComplete: @escaping(Bool) -> Void) {
        guard let user = authenticateUserProfile() else {
            onComplete(false)
            return
        }
        
        if currentlyStoredData["stepsCount"] as! Int != steps {
            apiClient.postStepsData(steps, forId: user.id) { result in
                // notification + "synchronised steps data"
                self.currentlyStoredData["stepsCount"] = steps
                onComplete(result)
            }
        }
        else {
            debugPrint("Steps data not modified.")
            onComplete(false)
        }
        
    }
}

