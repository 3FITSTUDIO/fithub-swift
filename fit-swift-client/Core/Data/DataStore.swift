//
//  DataStore.swift
//  fit-swift-client
//
//  Created by admin on 25/04/2020.
//  Copyright © 2020 Dominik Urbaez Gomez. All rights reserved.
//

import Foundation

class DataStore {
    private var apiClient: DataNetworking
    public var notificationsManager = NotificationsManager()
    
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
    private var isStepsDataPosted = false
    
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
    
    var measurementsData: [BodyMeasurements] {
        return currentlyStoredData[.measurements] as? [BodyMeasurements] ?? [BodyMeasurements]()
    }
    
    init() {
        apiClient = DataNetworking()
        apiClient.store = self
        clearCurrentData()
    }
    
    private func currentUser() -> User? {
        return mainStore.userStore.currentUser
    }
    
    func authenticateUserProfile() -> User? {
        guard let user = currentUser() else {
            debugPrint("USER_ERROR: Failed to authenticate user profile.")
            return nil
        }
        return user
    }
    
    func clearCurrentData() {
        currentlyStoredData.keys.forEach { currentlyStoredData[$0] = nil }
        notificationsManager.clearAllData()
        isDataFetched = false
    }
    
    func updateDataInViewModels() {
        weightsViewModel?.updateData()
        caloriesViewModel?.updateData()
    }
    
    func fetchAllData(force: Bool, onComplete: @escaping() -> Void) {
        //        HealthKitDataHandler.getLatestHearRateSample { _ in
        //            return
        //        }
        guard !isDataFetched || force else {
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
        fetchTrainingData {
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
        dispatchGroup.enter()
        notificationsManager.updateAllNotifications() {
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) {
            debugPrint("Finished fetching all data.")
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
    
    func fetchTrainingData(onComplete: @escaping() -> Void)  {
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
        apiClient.fetchBodyMeasurementsData(forUserId: user.id, dataType: .measurements) { result in
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
        guard !isStepsDataPosted else { return }
        guard let user = authenticateUserProfile() else {
            onComplete(false)
            return
        }
        
        if currentlyStoredData[.steps] as? Int != steps {
            apiClient.postStepsData(steps, forId: user.id) { result in
                // notification + "synchronised steps data"
                if result {
                    self.fetchStepsData {
                        self.isStepsDataPosted = true
                        onComplete(result)
                    }
                }
                else {
                    debugPrint("Failed to update steps data.")
                    onComplete(false)
                }
            }
        }
        else {
            debugPrint("Steps data not modified.")
            onComplete(false)
        }
    }
    
    func postRegularData(type: DataProvider.DataType, value: Float, date: String, onComplete: @escaping(Bool) -> Void) {
        guard let user = authenticateUserProfile() else {
            onComplete(false)
            return
        }
        apiClient.postRegularData(type: type, value: value, date: date, userId: user.id) { result in
            if result {
                switch type {
                case .weights:
                    self.fetchWeightData {
                        onComplete(true)
                    }
                case .kcal:
                    self.fetchCaloriesData {
                        onComplete(true)
                    }
                case .training:
                    self.fetchTrainingData {
                        onComplete(true)
                    }
                case .sleep:
                    self.fetchSleepData {
                        onComplete(true)
                    }
                case .pulse:
                    self.fetchPulseData {
                        onComplete(true)
                    }
                case .steps:
                    self.fetchStepsData {
                        onComplete(true)
                    }
                case .measurements:
                    self.fetchMeasurementsData {
                        onComplete(true)
                    }
                }
            }
            else {
                debugPrint("Failed to update \(type.rawValue) data.")
                onComplete(result)
            }
        }
    }
    
    func postBodyData(values: [Float], date: String, onComplete: @escaping(Bool) -> Void) {
        guard let user = authenticateUserProfile() else {
            onComplete(false)
            return
        }
        
        apiClient.postBodyData(values: values, forId: user.id) { result in
            // notification + "synchronised steps data"
            if result {
                self.fetchMeasurementsData {
                    onComplete(result)
                }
            }
            else {
                debugPrint("Failed to update body measurements data.")
                onComplete(false)
            }
        }
    }
}

