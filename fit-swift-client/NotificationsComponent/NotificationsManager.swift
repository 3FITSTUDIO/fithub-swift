//
//  NotificationsManager.swift
//  fit-swift-client
//
//  Created by admin on 18/05/2020.
//  Copyright © 2020 Dominik Urbaez Gomez. All rights reserved.
//

import Foundation

class NotificationsManager {
    
    private let apiClient = NotificationsNetworking()
    weak var delegate: NotificationsViewController?
    private var notificationData = [FithubNotification]()
    
    func authenticateUserProfile() -> User? {
        guard let user = mainStore.userStore.currentUser else {
            debugPrint("USER_ERROR: Failed to authenticate user profile.")
            return nil
        }
        return user
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
    
    func provideCurrentNotificationsCount() -> Int {
        return notificationData.count
    }
    
    func dataForNotification(forIndex index: Int) -> FithubNotification {
        let notification = notificationData[index]
        return notification
    }
    
    func clearAllData() {
        notificationData = [FithubNotification]()
    }
    
    func markAsRead(atIndex index: Int, onComplete: @escaping() -> Void) {
        let removed = notificationData.remove(at: index)
        notificationData.append(removed)
        onComplete()
    }
    
    func deleteNotification(atIndex index: Int, onComplete: @escaping() -> Void) {
        let removed = notificationData.remove(at: index)
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
}
