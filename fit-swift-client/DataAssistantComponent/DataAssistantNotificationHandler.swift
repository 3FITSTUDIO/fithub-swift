//
//  DataAssistantNotificationHandler.swift
//  Fithub
//
//  Created by admin on 20/05/2020.
//  Copyright © 2020 Dominik Urbaez Gomez. All rights reserved.
//

import Foundation

class DataAssistantNotificationHandler {
    enum LocalNotificationType: String {
        case welcome = "Hi! Welcome to Fithub, make sure to check your data in Dashboard."
        case dataNotFetched = "Unfortunately we were unable to fetch some data. Try updating again or re-login."
        case allDataFetched = "All data has been fetched! Make sure to check it in Dashboard."
        case checkWebVersion = "Make sure to check the online version of our app!"
    }
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
    
    func generateLocalNotifications(messages: [String]) {
        for message in messages {
            store.notificationsManager.createNewLocalNotification(message: message)
        }
    }
    
    func generateLocalNotificationMessage(type: LocalNotificationType) -> String {
        return type.rawValue
    }
    
    func generateAllLocalNotificationMessages() -> [String] {
        var messages = [String]()
        messages.append(generateLocalNotificationMessage(type: .welcome))
        messages.append(generateLocalNotificationMessage(type: .checkWebVersion))
        return messages
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
