//
//  StepsRecord.swift
//  fit-swift-client
//
//  Created by admin on 07/01/2020.
//  Copyright © 2020 Dominik Urbaez Gomez. All rights reserved.
//

import Foundation

struct Record: Codable {
    
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
    public var value: Double
    public var date: String
    
    init(id: Int, userId: Int, value: Double, date: String) {
        self.id = id
        self.userId = userId
        self.value = value
        self.date = date
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
        
        guard let value = json["value"] as? Double else {
            throw SerializationError.missing("value")
        }
        
        guard let date = json["date"] as? String else {
            throw SerializationError.missing("date")
        }
        
        self.id = id
        self.userId = userId
        self.value = value
        self.date = date
    }
    
}

