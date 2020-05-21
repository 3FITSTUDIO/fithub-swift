//
//  DataAssistantNotificationHandler.swift
//  Fithub
//
//  Created by admin on 20/05/2020.
//  Copyright © 2020 Dominik Urbaez Gomez. All rights reserved.
//

import Foundation

class DataAssistantNotificationHandler {
    enum NotificationType: String {
        case bmi = "BMI calculated from you weight and height"
    }
    var store: DataStore!
    weak var analyst: DataAssistantAnalyst?
    
    func generateNecessaryNotifications(messages: [String], onComplete: @escaping() -> Void) {
        var successfullyCreated = 0
        let group = DispatchGroup()
        for message in messages {
            group.enter()
            store.notificationsManager.createNewNotification(message: message) { result in
                if result {
                    successfullyCreated += 1
                }
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            debugPrint("Successfully created \(successfullyCreated)/\(messages.count) notifications.")
            onComplete()
            return
        }
    }
    
    func generateNotificationMessage(type: NotificationType) -> String {
        guard let analyst = analyst else { return "Something went wrong, sorry!" }
        var message = "Your " + type.rawValue + " is equal to: "
        switch type {
        case .bmi:
            if let bmi = analyst.bmiValue {
                message +=  String(bmi)
            }
        }
        return message
    }
}
