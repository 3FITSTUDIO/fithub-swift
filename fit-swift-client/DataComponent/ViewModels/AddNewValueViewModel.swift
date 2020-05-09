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
    private var store: UserStore?
    
    init() {
        store = mainStore.userStore
    }
    
//    func postNewRecord(value: Int, date: Date, type: NewValueType) -> Bool {
////        return true
//        var success = false
//        if let store = store {
//            switch type {
//            case .weight:
//                success = store.postNewWeightsRecord(value: value, date: date)
//            case .calories:
//                success = store.postNewCaloriesRecord(value: value, date: date)
//            }
//        }
//        return success
//    }
}
