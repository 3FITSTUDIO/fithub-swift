//
//  HealthKitDataHandler.swift
//  fit-swift-client
//
//  Created by admin on 18/05/2020.
//  Copyright © 2020 Dominik Urbaez Gomez. All rights reserved.
//

import Foundation
import HealthKit

class HealthKitDataHandler {
    
    // MARK: Get Permissions
    static func getHealthKitPermission(_ healthStore: HKHealthStore) {
        let stepsType = HKObjectType.quantityType(forIdentifier: .stepCount)!
        let heartRateType = HKObjectType.quantityType(forIdentifier: .heartRate)!
        healthStore.requestAuthorization(toShare: [], read: [stepsType, heartRateType]) { (success, error) in }
    }
    
    // MARK: Get Today's steps
    static func getTodaysSteps(completion: @escaping (Double) -> Void) {
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
    
    // MARK: Get Heart Rate Data
    static func getLatestHearRateSample(completion: @escaping (Float) -> Void) {
        fetchLatestHeartRateSample() { samples in
            let data = HealthKitHelper.calculateAverageHeartRatePerDay(samples: samples)
        }
    }
    static func fetchLatestHeartRateSample(completion: @escaping (_ samples: [HKQuantitySample]?) -> Void) {
        
        /// Create sample type for the heart rate
        guard let sampleType = HKObjectType
            .quantityType(forIdentifier: .heartRate) else {
                completion(nil)
                return
        }
        
        /// Predicate for specifiying start and end dates for the query
        let predicate = HKQuery
            .predicateForSamples(
                withStart: Calendar.current.date(byAdding: .day, value: -30, to: Date()),
                end: Date(),
                options: .strictEndDate)
        
        /// Set sorting by date.
        let sortDescriptor = NSSortDescriptor(
            key: HKSampleSortIdentifierStartDate,
            ascending: false)
        
        /// Create the query
        let query = HKSampleQuery(
            sampleType: sampleType,
            predicate: predicate,
            limit: Int(HKObjectQueryNoLimit),
            sortDescriptors: [sortDescriptor]) { (_, results, error) in
                
                guard error == nil else {
                    print("Error: \(error!.localizedDescription)")
                    return
                }
                
                
                completion(results as? [HKQuantitySample])
        }
        
        /// Execute the query in the health store
        let healthStore = HKHealthStore()
        healthStore.execute(query)
    }
}
