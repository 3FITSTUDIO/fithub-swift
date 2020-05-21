//
//  DashboardViewModel.swift
//  fit-swift-client
//
//  Created by admin on 05/11/2019.
//  Copyright © 2019 Dominik Urbaez Gomez. All rights reserved.
//

import Foundation

class DashboardViewModel {
    private var userStore: UserStore
    private var dataStore: DataStore
    weak var vc: DashboardViewController?
    
    init() {
        dataStore = mainStore.dataStore
        userStore = mainStore.userStore
    }
    
    func updateData(force: Bool) {
        if let vc = vc {
            dataStore.fetchAllData(force: force) { [weak self] in
                vc.weightDataButton.mainLabel.text = self?.provideLastRecord(dataType: .weight)
                vc.kcalDataButton.mainLabel.text = self?.provideLastRecord(dataType: .calories)
                vc.trainingsDataButton.mainLabel.text = self?.provideLastRecord(dataType: .training)
                vc.sleepDataButton.mainLabel.text = self?.provideLastRecord(dataType: .sleep)
                vc.pulseDataButton.mainLabel.text = self?.providePulseAvgRecord()
                vc.stepsDataButton.mainLabel.text = self?.provideStepsAvgRecord()
                // measurementsDataButton doesn't show any values
            }
        }
    }
    
    private func provideLastRecord(dataType: DataStore.DataType) -> String {
        switch dataType {
        case .weight:
            if let last = dataStore.weightData.last {
                return last.value.truncateTrailingZeros
            }
        case .calories:
            if let last = dataStore.caloriesData.last {
                return last.value.truncateTrailingZeros
            }
        case .training:
            if let last = dataStore.trainingData.last {
                return last.value.truncateTrailingZeros
            }
        case .sleep:
            if let last = dataStore.sleepData.last {
                return last.value.truncateTrailingZeros
            }
        case .pulse:
            if let last = dataStore.pulseData.last {
                return last.value.truncateTrailingZeros
            }
        case .steps:
            if let last = dataStore.stepsData.last {
                return last.value.truncateTrailingZeros
            }
        default:
            return ""
        }
        return ""
    }
    
    private func providePulseAvgRecord() -> String {
        let records = dataStore.pulseData
        var sum: Float = 0
        records.forEach {
            sum += $0.value
        }
        let avg = sum / Float(records.count)
        let avgRounded = round(10 * avg) / 10
        return avgRounded.truncateTrailingZeros
    }
    
    private func provideStepsAvgRecord() -> String {
        let records = dataStore.stepsData
        var sum: Float = 0
        records.forEach {
            sum += $0.value
        }
        let avg = sum / Float(records.count)
        let avgRounded = round(10 * avg) / 10
        return avgRounded.rounded().truncateTrailingZeros
    }
    
    func clearProfileOnLogout() {
        userStore.clearProfileOnLogout()
        dataStore.clearCurrentData()
    }
    
    func diagramsCanBeShown() -> Bool {
        let weightArray = dataStore.weightData
        let caloriesArray = dataStore.caloriesData
        return !weightArray.isEmpty && !caloriesArray.isEmpty
    }
}
