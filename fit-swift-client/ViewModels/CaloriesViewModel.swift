//
//  CaloriesViewModel.swift
//  fit-swift-client
//
//  Created by admin on 13/01/2020.
//  Copyright © 2020 Dominik Urbaez Gomez. All rights reserved.
//

import Foundation
import UIKit

class CaloriesViewModel {
    private weak var vc: CaloriesViewController?
    private var store: UserStore?
    
    init() {
        store = mainStore.userStore
        stubRecordArray()
    }
    
    func fetchCaloriesData() -> [Record] {
        return recordArray
    }
    
    func fetchCaloriesDataForCell(forIndex index: Int) -> Record {
        let record = recordArray[index]
        return record
    }
    
    var recordArray = [Record]()
    private func stubRecordArray() {
        recordArray.append(Record(id: 1, value: [2050], type: .kcal))
        recordArray.append(Record(id: 2, value: [2069], type: .kcal))
        recordArray.append(Record(id: 3, value: [2056], type: .kcal))
        recordArray.append(Record(id: 4, value: [2057], type: .kcal))
        recordArray.append(Record(id: 5, value: [2056], type: .kcal))
        recordArray.append(Record(id: 6, value: [2086], type: .kcal))
        recordArray.append(Record(id: 7, value: [2057], type: .kcal))
        recordArray.append(Record(id: 8, value: [2063], type: .kcal))
    }
}
