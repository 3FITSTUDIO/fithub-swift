//
//  StepsRecord.swift
//  fit-swift-client
//
//  Created by admin on 07/01/2020.
//  Copyright © 2020 Dominik Urbaez Gomez. All rights reserved.
//

import Foundation

class Record {
    
    public var id: Int
    public var value: [Int]
    public var type: RecordType
    
    init(id: Int, value: [Int], type: RecordType = .measurement) {
        self.id = id
        self.value = value
        self.type = type
    }
}
