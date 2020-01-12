//
//  StepsRecord.swift
//  fit-swift-client
//
//  Created by admin on 07/01/2020.
//  Copyright © 2020 Dominik Urbaez Gomez. All rights reserved.
//

import Foundation

class MeasurementRecord : Record {
    
//    0 neck
//    1 chest
//    2 bicep
//    3 forearm
//    4 stomach
//    5 waist
//    6 thigh
//    7 calf
    
    init(id: Int,
         neck: Int,
         chest: Int,
         bicep: Int,
         forearm: Int,
         stomach: Int,
         waist: Int,
         thigh: Int,
         calf: Int) {
        let values = [neck, chest, bicep, forearm, stomach, waist, thigh, calf]
        super.init(id: id, value: values)
    }
}
