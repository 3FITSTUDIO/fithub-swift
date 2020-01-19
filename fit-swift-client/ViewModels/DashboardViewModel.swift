//
//  DashboardViewModel.swift
//  fit-swift-client
//
//  Created by admin on 05/11/2019.
//  Copyright © 2019 Dominik Urbaez Gomez. All rights reserved.
//

import Foundation

class DashboardViewModel {
    private var store: UserStore?
    weak var vc: DashboardViewController?
    
    var weightArray = [Record]()
    var caloriesArray = [Record]()
    
    init() {
        store = mainStore.userStore
        if let store = store {
            DispatchQueue.main.async {
                store.fetchWeightData()
                store.fetchCaloriesData()
                self.weightArray = store.weightData
                self.caloriesArray = store.caloriesData
            }
        }
    }
    
    func provideLastWeightRecord() -> String {
        if let last = weightArray.last {
            return String(last.value[0])
        }
        return ""
    }
    
    func provideLastCaloriesRecord() -> String {
        if let last = caloriesArray.last {
            return String(last.value[0])
        }
        return ""
    }
    
    func postStepsData(steps: Int) {
        if let store = store {
            if !store.postStepsData(steps) {
                debugPrint("Failed to post steps data to server.")
            }
        }
    }
    
      
}
