//
//  ProfileViewModel.swift
//  fit-swift-client
//
//  Created by admin on 18/05/2020.
//  Copyright © 2020 Dominik Urbaez Gomez. All rights reserved.
//

import Foundation
import RxSwift

class ProfileViewModel {
    
    let disposeBag = DisposeBag()
    
    private var userStore: UserStore
    private var dataStore: DataStore
    weak var vc: ProfileViewController?
    
    private var initialNotificationsSent = false
    
    init() {
        dataStore = mainStore.dataStore
        userStore = mainStore.userStore
        subscribeToNotificationsCount()
    }
    
    func clearProfileOnLogout() {
        userStore.clearProfileOnLogout()
        dataStore.clearCurrentData()
    }
    
    private func currentUser() -> User? {
        return mainStore.userStore.currentUser
    }
    
    func authenticateUserProfile() -> User? {
        guard let user = currentUser() else {
            debugPrint("USER_ERROR: Failed to authenticate user profile.")
            return nil
        }
        return user
    }
    
    func getUserName() -> String {
        guard let user = authenticateUserProfile() else { return "" }
        return user.firstName
    }
    
    func updateData(force: Bool) {
        dataStore.fetchAllData(force: force) { }
    }
    
    func triggerNotificationsFetch(onComplete: @escaping() -> Void) {
        dataStore.notificationsManager.updateAllNotifications {
            onComplete()
        }
    }
    
    private func subscribeToNotificationsCount() {
        dataStore.notificationsManager.notificationDataObservable.subscribe(onNext: { [weak self] data in
            self?.vc?.notificationsCountIcon.updateDisplayCount(newVal: data.count)
        }).disposed(by: disposeBag)
    }
}
