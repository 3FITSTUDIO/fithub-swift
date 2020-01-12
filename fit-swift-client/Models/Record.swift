//
//  StepsRecord.swift
//  fit-swift-client
//
//  Created by admin on 07/01/2020.
//  Copyright © 2020 Dominik Urbaez Gomez. All rights reserved.
//

import Foundation

class Record {
    
    //    0 neck
    //    1 chest
    //    2 bicep
    //    3 forearm
    //    4 stomach
    //    5 waist
    //    6 thigh
    //    7 calf
    
    public var id: Int
    public var value: [Int]
    public var type: RecordType
    
    init(id: Int, value: [Int], type: RecordType) {
        self.id = id
        self.value = value
        self.type = type
    }
}
