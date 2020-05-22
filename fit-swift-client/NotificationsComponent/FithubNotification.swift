//
//  FithubNotification.swift
//  fit-swift-client
//
//  Created by admin on 18/05/2020.
//  Copyright © 2020 Dominik Urbaez Gomez. All rights reserved.
//

import Foundation

class FithubNotification {
    var id: Int
    var userId: Int
    var date: String
    var message: String
    
    init(json: [String: Any]) throws {
        guard let id = json["id"] as? Int else {
            throw SerializationError.missing("id")
        }
        
        guard let userId = json["userId"] as? Int else {
            throw SerializationError.missing("userId")
        }
        
        guard let date = json["date"] as? String else {
            throw SerializationError.missing("date")
        }
        
        guard let message = json["message"] as? String else {
            throw SerializationError.missing("message")
        }
        
        self.id = id
        self.userId = userId
        self.date = date
        self.message = message
    }
}

extension FithubNotification: Equatable {
    static func ==(lhs: FithubNotification, rhs: FithubNotification) -> Bool {
        guard lhs.id == rhs.id else { return false }
        guard lhs.userId == rhs.userId else { return false }
        guard lhs.message == rhs.message else { return false }
        guard lhs.date == rhs.date else { return false }
        return  true
    }
}
