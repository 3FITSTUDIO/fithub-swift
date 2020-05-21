//
//  DataStore.swift
//  fit-swift-client
//
//  Created by admin on 25/04/2020.
//  Copyright © 2020 Dominik Urbaez Gomez. All rights reserved.
//

import Foundation
import RxSwift

class DataStore {
    let disposeBag = DisposeBag()
    
    public var notificationsManager = NotificationsManager()
    private var dataAssistant = DataAssistantAnalyst()
    var handler: DataNetworkHandler!
    
    private var initialConfigComplete = false
    
    enum DataType {
        case weight, calories, training, sleep, pulse, steps, measurements
    }
    private var currentlyStoredData = [DataType: Any?]()
    
    var weightData = [Record]()
    var caloriesData = [Record]()
    var trainingData = [Record]()
    var sleepData = [Record]()
    var pulseData = [Record]()
    var stepsData = [Record]()
    var measurementsData = [BodyMeasurements]()
    
    init(dataHandler: DataNetworkHandler = DataNetworkHandler()) {
        handler = dataHandler
        handler.store = self
        dataAssistant.store = self
        dataAssistant.configureNotificationsHandler()
        clearCurrentData()
        bindToHandler(dataHandler)
    }
    
    private func bindToHandler(_ handler: DataNetworkHandler) {
        handler.weightData.subscribe(onNext: { [weak self] data in
            self?.weightData = data
        }).disposed(by: disposeBag)
        
        handler.caloriesData.subscribe(onNext: { [weak self] data in
            self?.caloriesData = data
        }).disposed(by: disposeBag)
        
        handler.trainingData.subscribe(onNext: { [weak self] data in
            self?.trainingData = data
        }).disposed(by: disposeBag)
        
        handler.sleepData.subscribe(onNext: { [weak self] data in
            self?.sleepData = data
        }).disposed(by: disposeBag)
        
        handler.pulseData.subscribe(onNext: { [weak self] data in
            self?.pulseData = data
        }).disposed(by: disposeBag)
        
        handler.stepsData.subscribe(onNext: { [weak self] data in
            self?.stepsData = data
        }).disposed(by: disposeBag)
        
        handler.measurementsData.subscribe(onNext: { [weak self] data in
            self?.measurementsData = data
        }).disposed(by: disposeBag)
    }
    
    func clearCurrentData() {
        currentlyStoredData.keys.forEach { currentlyStoredData[$0] = nil }
        notificationsManager.clearAllData()
        initialConfigComplete = false
    }
    
    func fetchAllData(force: Bool, onComplete: @escaping() -> Void) {
        //        HealthKitDataHandler.getLatestHearRateSample { _ in
        //            return
        //        }
        guard !initialConfigComplete || force else {
            onComplete()
            return
        }
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        handler.fetchWeightData {
            dispatchGroup.leave()
        }
        dispatchGroup.enter()
        handler.fetchCaloriesData {
            dispatchGroup.leave()
        }
        dispatchGroup.enter()
        handler.fetchTrainingData {
            dispatchGroup.leave()
        }
        dispatchGroup.enter()
        handler.fetchSleepData {
            dispatchGroup.leave()
        }
        dispatchGroup.enter()
        handler.fetchPulseData {
            dispatchGroup.leave()
        }
        dispatchGroup.enter()
        handler.fetchStepsData {
            dispatchGroup.leave()
        }
        dispatchGroup.enter()
        handler.fetchMeasurementsData {
            dispatchGroup.leave()
        }
        dispatchGroup.enter()
        dataAssistant.performGeneralAnalysis {
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) {
            debugPrint("Finished fetching all data.")
            self.notificationsManager.updateAllNotifications() {
                self.initialConfigComplete = true
                onComplete()
            }
        }
    }
    
}

