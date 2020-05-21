//
//  CaloriesViewModel.swift
//  fit-swift-client
//
//  Created by admin on 13/01/2020.
//  Copyright © 2020 Dominik Urbaez Gomez. All rights reserved.
//

import Foundation

class CaloriesViewModel: DataSourceViewModel {
    weak var vc: RecordsTableViewViewController?
    var store: DataStore
    
    var data = [Record]()
    var bodyData = [BodyMeasurements]()
    
    init() {
        store = mainStore.dataStore
        data = store.caloriesData
    }
    
    func fetchDataForCell(forIndex index: Int) -> DataFetched {
        let record = data.reversed()[index]
        return record
    }
}
