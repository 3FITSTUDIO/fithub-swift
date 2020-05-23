//
//  NotificationsManager.swift
//  fit-swift-client
//
//  Created by admin on 18/05/2020.
//  Copyright © 2020 Dominik Urbaez Gomez. All rights reserved.
//

import Foundation
import RxSwift

class NotificationsManager {
    
    private let apiClient = NotificationsNetworking()
    
    private var notificationDataSubject = BehaviorSubject.init(value: [FithubNotification]())
    var notificationDataObservable: Observable<[FithubNotification]> {
        return notificationDataSubject.asObservable()
    }
    
    var notificationData = [FithubNotification]() {
        didSet {
            notificationDataSubject.onNext(notificationData)
        }
    }
    
    func authenticateUserProfile() -> User? {
        guard let user = mainStore.userStore.currentUser else {
            debugPrint("USER_ERROR: Failed to authenticate user profile.")
            return nil
        }
        return user
    }
    
    func clearAllData() {
        notificationData.removeAll()
    }
    
    func updateAllNotifications(onComplete: @escaping() -> Void) {
        guard let user = authenticateUserProfile() else {
            onComplete()
            return
        }
        apiClient.fetchAllUserNotifications(forUserId: user.id) { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let fetchedData):
                self?.notificationData = fetchedData.reversed()
            }
            onComplete()
        }
    }
    
    func createNewNotification(message: String, onComplete: @escaping(Bool) -> Void) {
        guard let userId = authenticateUserProfile()?.id else {
            onComplete(false)
            return
        }
        let date = FitHubDateFormatter.formatDate(Date())
        
        apiClient.postNotification(userId: userId, date: date, message: message) { result in
            switch result {
            case .failure:
                debugPrint("Failed to create notification")
                onComplete(false)
            case .success(let notification):
                self.notificationData.append(notification)
                onComplete(true)
            }
        }
    }
    
    func createNewLocalNotification(message: String) {
        guard let userId = authenticateUserProfile()?.id else {
            return
        }
        let date = FitHubDateFormatter.formatDate(Date())
        let notification = FithubNotification(id: 0, userId: userId, date: date, message: message, isGlobal: false)
        notificationData.append(notification)
    }
    
    // MARK: Notification View Controller Data Source
    
    func dataForNotification(forIndex index: Int) -> FithubNotification {
        let notification = notificationData[index]
        return notification
    }
    
    func markAsRead(atIndex index: Int, onComplete: @escaping() -> Void) {
        let removed = notificationData.remove(at: index)
        notificationData.append(removed)
        onComplete()
    }
    
    func deleteNotification(atIndex index: Int, onComplete: @escaping() -> Void) {
        let removed = notificationData.remove(at: index)
        if removed.isGlobal {
            apiClient.deleteNotification(id: removed.id) { [weak self] result in
                if result {
                    self?.updateAllNotifications() {
                        debugPrint("Notification update completed")
                        onComplete()
                    }
                }
                else {
                    debugPrint("Notification update failed.")
                    onComplete()
                }
            }
        }
        else {
            onComplete()
        }
    }
}
