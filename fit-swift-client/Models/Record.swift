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
    public var value: Int
    public var date: String
    
    init(id: Int, value: Int, date: String) {
        self.id = id
        self.value = value
        self.date = date
    }
}

extension Record {
    init(json: [String: Any]) throws {
        guard let id = json["id"] as? Int else {
            throw SerializationError.missing("id")
        }
        
        guard let value = json["value"] as? Int else {
            throw SerializationError.missing("value")
        }
        
        guard let date = json["type"] as? String else {
            throw SerializationError.missing("date")
        }
        
        self.id = id
        self.value = value
        self.date = date
    }
    
}

