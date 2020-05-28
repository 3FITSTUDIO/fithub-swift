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
    private var store: DataStore
    
    init() {
        store = mainStore.dataStore
    }
    
    func validateEnteredData(value: String) -> Bool {
        guard value != "" else { return false }
        guard value.first != Character("0") else { return false }
        return true
    }
    
    func validateBodyData(values: [String?]) -> Bool {
        var flag = true
        values.forEach {
            if let value = $0 {
                // starts with 0
                if value.first == "0" {
                    flag = false
                    return
                } // empty string
                if value == "" {
                    flag = false
                    return
                } // more than 3 characters
                if value.count > 3 {
                    flag = false
                    return
                }
            }
            else { // any value is nil
                flag = false
                return
            }
        }
        return flag
    }
    
    func postNewRecord(value: String, date: Date, type: DataProvider.DataType, onComplete: @escaping(Bool) -> Void) {
        let valueFormatted = Float(value)
        let dateFormatted = FitHubDateFormatter.formatDate(date)
        if let val = valueFormatted {
            store.handler.postRegularData(type: type, value: val, date: dateFormatted) { result in
                onComplete(result)
            }
        }
        else {
            debugPrint("VM_ERROR: Failed to post \(type.rawValue) data")
            onComplete(false)
        }
    }
    
    func postBodyData(values: [String], date: Date, onComplete: @escaping(Bool) -> Void) {
        let valuesToFloat = values.map { Float($0) }
        let dateFormatted = FitHubDateFormatter.formatDate(date)
        let valFloatUnwrapped = valuesToFloat.map { $0 ?? 0 }
        store.handler.postBodyData(values: valFloatUnwrapped, date: dateFormatted) { result in
            onComplete(result)
        }
    }
}
