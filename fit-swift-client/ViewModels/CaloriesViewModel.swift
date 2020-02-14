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
    
    var caloriesArray = [Record]()
    
    init() {
        store = mainStore.userStore
        if let store = store {
            caloriesArray = store.caloriesData
        }
    }
    
    func fetchCaloriesData() -> [Record] {
        return caloriesArray
    }
    
    func fetchCaloriesDataForCell(forIndex index: Int) -> Record {
        let record = caloriesArray[index]
        return record
    }
}
