//
//  DashboardViewModel.swift
//  fit-swift-client
//
//  Created by admin on 05/11/2019.
//  Copyright © 2019 Dominik Urbaez Gomez. All rights reserved.
//

import Foundation

class DashboardViewModel {
    private var userStore: UserStore?
    private var dataStore: DataStore?
    weak var vc: DashboardViewController?
    
    init() {
        dataStore = mainStore.dataStore
        userStore = mainStore.userStore
    }
    
    func updateData() {
        if let store = dataStore, let vc = vc {
            store.fetchAllData() {
                vc.weightDataButton.mainLabel.text = self.provideLastRecord(dataType: .weight)
                vc.kcalDataButton.mainLabel.text = self.provideLastRecord(dataType: .calories)
                vc.trainingsDataButton.mainLabel.text = self.provideLastRecord(dataType: .training)
                vc.sleepDataButton.mainLabel.text = self.provideLastRecord(dataType: .sleep)
                vc.pulseDataButton.mainLabel.text = self.provideLastRecord(dataType: .pulse)
                vc.stepsDataButton.mainLabel.text = self.provideLastRecord(dataType: .steps)
                // measurementsDataButton doesn't show any values
            }
        }
    }
    
    private func provideLastRecord(dataType: DataStore.DataType) -> String {
        switch dataType {
        case .weight:
            if let last = dataStore?.weightData.last {
                return last.value.truncateTrailingZeros
            }
        case .calories:
            if let last = dataStore?.caloriesData.last {
                return last.value.truncateTrailingZeros
            }
        case .training:
            if let last = dataStore?.trainingData.last {
                return last.value.truncateTrailingZeros
            }
        case .sleep:
            if let last = dataStore?.sleepData.last {
                return last.value.truncateTrailingZeros
            }
        case .pulse:
            if let last = dataStore?.pulseData.last {
                return last.value.truncateTrailingZeros
            }
        case .steps:
            if let last = dataStore?.stepsData.last {
                return last.value.truncateTrailingZeros
            }
        case .measurements:
            if let last = dataStore?.measurementsData.last {
                return last.value.truncateTrailingZeros
            }
        }
        return ""
    }
    
    func clearProfileOnLogout() {
        if let userStore = userStore, let dataStore = dataStore {
            userStore.clearProfileOnLogout()
            dataStore.clearCurrentData()
        }
    }
}
