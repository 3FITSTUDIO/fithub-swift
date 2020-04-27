//
//  WeightsViewModel.swift
//  fit-swift-client
//
//  Created by admin on 13/01/2020.
//  Copyright © 2020 Dominik Urbaez Gomez. All rights reserved.
//

import Foundation
import UIKit

class WeightsViewModel {
    private weak var vc: WeightsViewController?
    private var store: DataStore?
    
    var weightArray = [Record]()
    
    init() {
        store = mainStore.dataStore
        if let store = store {
            weightArray = store.weightData
            store.weightsViewModel = self
        }
        updateData()
    }
    
    func fetchWeightData() -> [Record] {
        return weightArray
    }
    
    func fetchWeightDataForCell(forIndex index: Int) -> Record {
        guard index <= weightArray.count else { return Record(id: 00, userId: 1, value: 0, date: FitHubDateFormatter.formatDate(Date.distantPast))}
        let record = weightArray[index]
        return record
    }
    
    func updateData() {
        if let store = store {
            weightArray = store.weightData
        }
        // trigger view update
    }
}
