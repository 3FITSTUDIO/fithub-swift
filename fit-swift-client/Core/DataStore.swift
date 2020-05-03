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
    
    weak var weightsViewModel: WeightsViewModel?
    weak var caloriesViewModel: CaloriesViewModel?
    weak var trainingsViewModel: TrainingsViewModel?
    weak var sleepViewModel: SleepViewModel?
    weak var pulseViewModel: PulseViewModel?
    weak var stepsViewModel: StepsViewModel?
    weak var measurementsViewModel: MeasurementsViewModel?
    
    enum DataType {
        case weight, calories, training, sleep, pulse, steps, measurements
    }
    
    private var currentlyStoredData = [DataType: Any?]()
    private var isDataFetched = false
    
    var weightData: [Record] {
        return currentlyStoredData[.weight] as? [Record] ?? [Record]()
    }
    
    var caloriesData: [Record] {
        return currentlyStoredData[.calories] as? [Record] ?? [Record]()
    }
    
    var trainingData: [Record] {
        return currentlyStoredData[.training] as? [Record] ?? [Record]()
    }
    
    var sleepData: [Record] {
        return currentlyStoredData[.sleep] as? [Record] ?? [Record]()
    }
    
    var pulseData: [Record] {
        return currentlyStoredData[.pulse] as? [Record] ?? [Record]()
    }
    
    var stepsData: [Record] {
        return currentlyStoredData[.steps] as? [Record] ?? [Record]()
    }
    
    var measurementsData: [Record] {
        return currentlyStoredData[.measurements] as? [Record] ?? [Record]()
    }
    
    init() {
        apiClient = DataNetworking()
        apiClient.store = self
        clearCurrentData()
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
    
    func clearCurrentData() {
        currentlyStoredData.keys.forEach { currentlyStoredData[$0] = nil }
        isDataFetched = false
    }
    
    func updateDataInViewModels() {
        weightsViewModel?.updateData()
        caloriesViewModel?.updateData()
    }
    
    func fetchAllData(onComplete: @escaping() -> Void) {
        guard !isDataFetched else {
            onComplete()
            return
        }
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        fetchWeightData {
            dispatchGroup.leave()
        }
        dispatchGroup.enter()
        fetchCaloriesData {
            dispatchGroup.leave()
        }
        dispatchGroup.enter()
        fetchTrainingsData {
            dispatchGroup.leave()
        }
        dispatchGroup.enter()
        fetchSleepData {
            dispatchGroup.leave()
        }
        dispatchGroup.enter()
        fetchPulseData {
            dispatchGroup.leave()
        }
        dispatchGroup.enter()
        fetchStepsData {
            dispatchGroup.leave()
        }
        dispatchGroup.enter()
        fetchMeasurementsData {
            dispatchGroup.leave()
        }
        dispatchGroup.notify(queue: .main) {
            debugPrint("Fetched all data successfully")
            self.isDataFetched = true
            onComplete()
        }
    }
    
    // MARK: Dashboard View Controller, Fetching all data, Posting steps data
    func fetchWeightData(onComplete: @escaping() -> Void)  {
        guard let user = authenticateUserProfile() else { return }
        apiClient.fetchRegularData(forUserId: user.id, dataType: .weights) { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let fetchedData):
                self.currentlyStoredData[.weight] = fetchedData
            }
            onComplete()
        }
    }
    
    func fetchCaloriesData(onComplete: @escaping() -> Void)  {
        guard let user = authenticateUserProfile() else { return }
        apiClient.fetchRegularData(forUserId: user.id, dataType: .calories) { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let fetchedData):
                self.currentlyStoredData[.calories] = fetchedData
            }
            onComplete()
        }
    }
    
    func fetchTrainingsData(onComplete: @escaping() -> Void)  {
        guard let user = authenticateUserProfile() else { return }
        apiClient.fetchRegularData(forUserId: user.id, dataType: .trainings) { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let fetchedData):
                self.currentlyStoredData[.training] = fetchedData
            }
            onComplete()
        }
    }
    
    func fetchSleepData(onComplete: @escaping() -> Void)  {
        guard let user = authenticateUserProfile() else { return }
        apiClient.fetchRegularData(forUserId: user.id, dataType: .sleep) { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let fetchedData):
                self.currentlyStoredData[.sleep] = fetchedData
            }
            onComplete()
        }
    }
    
    func fetchPulseData(onComplete: @escaping() -> Void)  {
        guard let user = authenticateUserProfile() else { return }
        apiClient.fetchRegularData(forUserId: user.id, dataType: .pulse) { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let fetchedData):
                self.currentlyStoredData[.pulse] = fetchedData
            }
            onComplete()
        }
    }
    
    func fetchStepsData(onComplete: @escaping() -> Void)  {
        guard let user = authenticateUserProfile() else { return }
        apiClient.fetchRegularData(forUserId: user.id, dataType: .steps) { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let fetchedData):
                self.currentlyStoredData[.steps] = fetchedData
            }
            onComplete()
        }
    }
    
    func fetchMeasurementsData(onComplete: @escaping() -> Void)  {
        guard let user = authenticateUserProfile() else { return }
        apiClient.fetchRegularData(forUserId: user.id, dataType: .measurements) { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let fetchedData):
                self.currentlyStoredData[.measurements] = fetchedData
            }
            onComplete()
        }
    }
    
    func postStepsData(_ steps: Int, onComplete: @escaping(Bool) -> Void) {
        return // dont post data in development
        guard let user = authenticateUserProfile() else {
            onComplete(false)
            return
        }
        
        if currentlyStoredData[.steps] as! Int != steps {
            apiClient.postStepsData(steps, forId: user.id) { result in
                // notification + "synchronised steps data"
                self.currentlyStoredData[.steps] = steps
                onComplete(result)
            }
        }
        else {
            debugPrint("Steps data not modified.")
            onComplete(false)
        }
        
    }
}

