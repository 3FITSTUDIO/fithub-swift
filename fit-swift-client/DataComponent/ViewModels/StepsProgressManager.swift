//
//  StepsProgressBarManager.swift
//  fit-swift-client
//
//  Created by admin on 08/01/2020.
//  Copyright © 2020 Dominik Urbaez Gomez. All rights reserved.
//

import Foundation
import HealthKit
import UIKit

class StepsProgressBarManager {
    
    let store: DataStore
    
    init() {
        store = mainStore.dataStore
    }
        
    func provideStepsCount(completion: @escaping (Int) -> Void) {
        HealthKitDataHandler.getTodaysSteps { [weak self] todaysSteps  in
            self?.store.handler.postStepsData(Int(todaysSteps)) { result in
                if result {
                    debugPrint("Succesfully sent steps data.")
                }
                else {
                    debugPrint("No steps data sent to server.")
                }
            }
            completion(Int(todaysSteps))
        }
    }
}
