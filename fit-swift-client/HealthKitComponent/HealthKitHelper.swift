//
//  HealthKitHelper.swift
//  fit-swift-client
//
//  Created by admin on 18/05/2020.
//  Copyright © 2020 Dominik Urbaez Gomez. All rights reserved.
//

import Foundation
import HealthKit

class HealthKitHelper {
    
    static func calculateAverageHeartRatePerDay(samples: [HKQuantitySample]?) -> [Float] {
        var results = [Float]()
        
        var lastHeartRate: Double
        
        if let unwrappedData = samples {
            for sample in unwrappedData {
                lastHeartRate = sample.quantity.doubleValue(for: .day())
            }
        }

        return results
    }
}
