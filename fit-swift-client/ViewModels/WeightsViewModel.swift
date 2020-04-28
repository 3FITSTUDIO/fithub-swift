//
//  WeightsViewModel.swift
//  fit-swift-client
//
//  Created by admin on 13/01/2020.
//  Copyright © 2020 Dominik Urbaez Gomez. All rights reserved.
//

import Foundation
import UIKit

class WeightsViewModel: DataSourceViewModel {    
    weak var vc: RecordsTableViewViewController?
    var store: DataStore?
    
    var data = [Record]()
    
    init() {
        store = mainStore.dataStore
        if let store = store {
            data = store.weightData
            store.weightsViewModel = self
        }
        updateData()
    }
    
    func fetchData() -> [Record] {
        return data
    }
    
    func fetchDataForCell(forIndex index: Int) -> Record {
        guard index <= data.count else { return Record(id: 00, userId: 1, value: 0, date: FitHubDateFormatter.formatDate(Date.distantPast))}
        let record = data.reversed()[index]
        return record
    }
    
    func updateData() {
        if let store = store {
            data = store.weightData
        }
        // trigger view update
    }
}
