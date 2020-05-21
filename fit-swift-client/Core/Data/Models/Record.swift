//
//  StepsRecord.swift
//  fit-swift-client
//
//  Created by admin on 07/01/2020.
//  Copyright © 2020 Dominik Urbaez Gomez. All rights reserved.
//

import Foundation

struct Record: DataFetched {
    
    public var id: Int
    public var userId: Int
    public var value: Float
    public var date: String
    
    var values: [Float]
    
    init(id: Int, userId: Int, value: Float, date: String) {
        self.id = id
        self.userId = userId
        self.value = value
        self.date = date
        
        self.values = [Float]() // not used at present
    }
}

extension Record {
    init(json: [String: Any]) throws {
        guard let id = json["id"] as? Int else {
            throw SerializationError.missing("id")
        }
        
        guard let userId = json["userId"] as? Int else {
            throw SerializationError.missing("userId")
        }
        
        guard let valueRaw = json["value"] as? NSNumber else {
            throw SerializationError.missing("value")
        }
        
        guard let date = json["date"] as? String else {
            throw SerializationError.missing("date")
        }
        
        self.id = id
        self.userId = userId
        self.date = date
        self.value = Float(truncating: valueRaw)
        self.values = [Float]()
    }
}

