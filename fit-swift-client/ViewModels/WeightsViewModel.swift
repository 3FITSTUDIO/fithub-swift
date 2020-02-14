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
    private var store: UserStore?
    
    var weightArray = [Record]()
    
    init() {
        store = mainStore.userStore
        if let store = store {
            weightArray = store.weightData
        }
    }
    
    func fetchWeightData() -> [Record] {
        return weightArray
    }
    
    func fetchWeightDataForCell(forIndex index: Int) -> Record {
        guard index <= weightArray.count else { return Record(id: 00, value: [00], date: FitHubDateFormatter.formatDate(Date.distantPast))}
        let record = weightArray[index]
        return record
    }
}
