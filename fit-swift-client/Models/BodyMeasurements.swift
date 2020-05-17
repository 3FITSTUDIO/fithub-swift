//
//  BodyMeasurements.swift
//  fit-swift-client
//
//  Created by admin on 05/05/2020.
//  Copyright © 2020 Dominik Urbaez Gomez. All rights reserved.
//

import Foundation

struct BodyMeasurements: Codable, DataFetched {
    
    //    0 neck
    //    1 chest
    //    2 bicep
    //    3 forearm
    //    4 stomach
    //    5 waist
    //    6 thigh
    //    7 calf
    
    public var id: Int
    public var userId: Int
    public var values: [Float]
    public var date: String
    
    public var value: Float // not used at present
    
    init(id: Int, userId: Int, values: [Float], date: String) {
        self.id = id
        self.userId = userId
        self.values = values
        self.date = date
        self.value = -1
    }
}

extension BodyMeasurements {
    init(json: [String: Any]) throws {
        guard let id = json["id"] as? Int else {
            throw SerializationError.missing("id")
        }
        
        guard let userId = json["userId"] as? Int else {
            throw SerializationError.missing("userId")
        }
        
        guard let values = json["values"] as? [Float] else {
            throw SerializationError.missing("value")
        }
        
        guard let date = json["date"] as? String else {
            throw SerializationError.missing("date")
        }
        
        self.id = id
        self.userId = userId
        self.values = values
        self.date = date
        self.value = -1
    }
    
}
