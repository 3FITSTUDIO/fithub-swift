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
        self.getTodaysSteps { (todaysSteps) -> ()  in
            self.store.postStepsData(Int(todaysSteps)) { result in
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

    private func getTodaysSteps(completion: @escaping (Double) -> Void) {
        guard HKHealthStore.isHealthDataAvailable() else { completion(0.0); return }
        let stepsQuantityType = HKQuantityType.quantityType(forIdentifier: .stepCount)!
        
        let now = Date()
        let startOfDay = Calendar.current.startOfDay(for: now)
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictStartDate)

        let healthStore = HKHealthStore()
        healthStore.execute(
            HKStatisticsQuery(quantityType: stepsQuantityType, quantitySamplePredicate: predicate, options: .cumulativeSum) { _, result, _ in
                guard let result = result, let sum = result.sumQuantity() else { completion(0.0); return }
                completion(sum.doubleValue(for: HKUnit.count()))
            }
        )
    }
    
    static func getHealthKitPermission(_ healthStore: HKHealthStore) {
        let type = HKObjectType.quantityType(forIdentifier: .stepCount)!
        healthStore.requestAuthorization(toShare: [], read: [type]) { (success, error) in }
    }
}
