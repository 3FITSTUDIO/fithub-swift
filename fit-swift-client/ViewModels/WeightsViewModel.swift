//
//  WeightsViewModel.swift
//  fit-swift-client
//
//  Created by admin on 13/01/2020.
//  Copyright © 2020 Dominik Urbaez Gomez. All rights reserved.
//

import Foundation

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
    }
    
    func fetchDataForCell(forIndex index: Int) -> Record {
        let record = data.reversed()[index]
        return record
    }
    
    func updateData() {
        if let store = store {
            data = store.weightData
        }
    }
}
