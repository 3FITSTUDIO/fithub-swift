//
//  DataAssistantAnalyst.swift
//  Fithub
//
//  Created by admin on 20/05/2020.
//  Copyright © 2020 Dominik Urbaez Gomez. All rights reserved.
//

import Foundation
import RxSwift

class DataAssistantAnalyst {
    
    var store: DataStore! {
        didSet {
            self.weightData = store.weightData
        }
    }
    private var notificationHandler = DataAssistantNotificationHandler()
    
    private var weeklyReportKey = "weekly_report_complete"
    
    var bmiValue: Float?
    
    private var messagesPending = [String]()
    private var localMessagesPending = [String]()
    
    private var weightData = [Record]()
    
    init() {
        notificationHandler.analyst = self
    }
    
    private func setupSubscriptions() {
        self.weightData = store.weightData
    }
    
    func configureNotificationsHandler() {
        notificationHandler.store = store
    }
    
    func performGeneralAnalysis(onComplete: @escaping() -> Void) {
        let reportComplete = UserDefaults.standard.bool(forKey: weeklyReportKey)
        guard reportComplete != true else {
            onComplete()
            return
        }
        performAllCalculations()
        prepareAllPendingMessages()
        notificationHandler.generateNecessaryNotifications(messages: messagesPending) {
            self.messagesPending.removeAll()
            UserDefaults.standard.set(true, forKey: self.weeklyReportKey)
            onComplete()
        }
    }
    
    private func performAllCalculations() {
        bmiValue = calculateBMI()
    }
    
    private func prepareAllPendingMessages() {
        // bmi
        messagesPending.append(notificationHandler.generateNotificationMessage(type: .bmi))
//        let localMessages = notificationHandler.generateAllLocalNotificationMessages()
//        for message in localMessages {
//            localMessagesPending.append(message)
//        }
    }
    
    func triggerLocalMessage(_ messageType: DataAssistantNotificationHandler.LocalNotificationType) {
        let message = notificationHandler.generateLocalNotificationMessage(type: messageType)
        localMessagesPending.append(message)
        notificationHandler.generateLocalNotifications(messages: localMessagesPending)
        localMessagesPending.removeAll()
    }
    
    private func calculateBMI() -> Float? {
        weightData = store.weightData
        guard let weightFloat = weightData.last?.value else { return nil }
        guard let heightUnwrapped = store.handler.authenticateUserProfile()?.height else { return nil }
        let heightInMeters = Float(Float(heightUnwrapped)/100)
        
        return weightFloat / (heightInMeters * heightInMeters)
    }
}
