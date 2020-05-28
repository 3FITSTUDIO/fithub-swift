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
    var dashboardViewModel: DashboardViewModel?
    var profileViewModel: ProfileViewModel?
    
    var initialConfigComplete = false
    
    enum DataType {
        case weight, calories, training, sleep, pulse, steps, measurements
    }
    
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
        var backgroundUpdateTimer = Timer.scheduledTimer(withTimeInterval: 60.0, repeats: true, block: { _ in
            self.dashboardViewModel?.updateData(force: true)
            self.profileViewModel?.updateTriggered()
        })
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
        weightData = [Record]()
        caloriesData = [Record]()
        trainingData = [Record]()
        sleepData = [Record]()
        pulseData = [Record]()
        stepsData = [Record]()
        measurementsData = [BodyMeasurements]()
        
        notificationsManager.clearAllData()
        initialConfigComplete = false
    }
    
    @objc
    func fetchAllData(force: Bool, onComplete: @escaping() -> Void) {
        guard !initialConfigComplete || force else {
            onComplete()
            return
        }
        var flag = true
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        handler.fetchWeightData { result in
            flag = result
            dispatchGroup.leave()
        }
        dispatchGroup.enter()
        handler.fetchCaloriesData { result in
            flag = result
            dispatchGroup.leave()
        }
        dispatchGroup.enter()
        handler.fetchTrainingData { result in
            flag = result
            dispatchGroup.leave()
        }
        dispatchGroup.enter()
        handler.fetchSleepData { result in
            flag = result
            dispatchGroup.leave()
        }
        dispatchGroup.enter()
        handler.fetchPulseData { result in
            flag = result
            dispatchGroup.leave()
        }
        dispatchGroup.enter()
        handler.fetchStepsData { result in
            flag = result
            dispatchGroup.leave()
        }
        dispatchGroup.enter()
        handler.fetchMeasurementsData { result in
            flag = result
            dispatchGroup.leave()
        }
        dispatchGroup.enter()
        dataAssistant.performGeneralAnalysis {
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) {
            debugPrint("Finished fetching all data.")
            self.notificationsManager.updateAllNotifications() { [weak self] in
                self?.initialConfigComplete = flag
                self?.generateDataFetchMessage(flag)
                onComplete()
            }
        }
    }
    
    private func generateDataFetchMessage(_ fetchResult: Bool) {
        var messageType: DataAssistantNotificationHandler.LocalNotificationType
        if fetchResult {
            messageType = .allDataFetched
        }
        else {
            messageType = .dataNotFetched
        }
        dataAssistant.triggerLocalMessage(messageType)
    }
    
}

