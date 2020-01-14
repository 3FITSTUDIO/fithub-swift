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
    
    init() {
        store = mainStore.userStore
        stubRecordArray()
    }
    
    func fetchWeightData() -> [Record] {
        return recordArray
    }
    
    func fetchWeightDataForCell(forIndex index: Int) -> Record {
        let record = recordArray[index]
        return record
    }
    
    var recordArray = [Record]()
    private func stubRecordArray() {
        recordArray.append(Record(id: 1, value: [88], type: .weight))
        recordArray.append(Record(id: 2, value: [87], type: .weight))
        recordArray.append(Record(id: 3, value: [87], type: .weight))
        recordArray.append(Record(id: 4, value: [85], type: .weight))
        recordArray.append(Record(id: 5, value: [85], type: .weight))
        recordArray.append(Record(id: 6, value: [85], type: .weight))
        recordArray.append(Record(id: 7, value: [84], type: .weight))
        recordArray.append(Record(id: 8, value: [82], type: .weight))
    }
}
