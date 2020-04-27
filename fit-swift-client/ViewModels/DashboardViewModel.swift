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
    
    var weightArray = [Record]()
    var caloriesArray = [Record]()
    
    init() {
        dataStore = mainStore.dataStore
        userStore = mainStore.userStore
        updateData()
    }
    
    func updateData() {
        if let store = dataStore {
            DispatchQueue.main.async {
                store.fetchWeightData()
                store.fetchCaloriesData()
                self.weightArray = store.weightData
                self.caloriesArray = store.caloriesData
                store.updateDataInViewModels()
            }
        }
    }
    
    func provideLastWeightRecord() -> String {
        if let last = weightArray.last {
            return String(last.value)
        }
        return ""
    }
    
    func provideLastCaloriesRecord() -> String {
        if let last = caloriesArray.last {
            return String(last.value)
        }
        return ""
    }
    
    func clearProfileOnLogout() {
        if let userStore = userStore, let dataStore = dataStore {
            userStore.clearProfileOnLogout()
            dataStore.clearDataOnLogout()
        }
    }
}
