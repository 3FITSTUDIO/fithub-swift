//
//  AddNewValueViewModel.swift
//  fit-swift-client
//
//  Created by admin on 14/01/2020.
//  Copyright © 2020 Dominik Urbaez Gomez. All rights reserved.
//

import Foundation
import UIKit

class AddNewValueViewModel {
    weak var vc: AddNewValueViewController?
    private var store: DataStore?
    
    init() {
        store = mainStore.dataStore
    }
    
    func validateEnteredData(value: String) -> Bool {
        guard value != "" else { return false }
        guard value.first != Character("0") else { return false }
        return true
    }
    
    func postNewRecord(value: String, date: Date, type: DataProvider.DataType, onComplete: @escaping(Bool) -> Void) {
        let valueFormatted = Float(value)
        let dateFormatted = FitHubDateFormatter.formatDate(date)
        if let store = store, let val = valueFormatted {
            store.postRegularData(type: type, value: val, date: dateFormatted) { result in
                onComplete(result)
            }
        }
        else {
            debugPrint("VM_ERROR: Failed to post \(type.rawValue) data")
            onComplete(false)
        }
    }
}
