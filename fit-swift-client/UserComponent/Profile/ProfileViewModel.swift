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
    var currentNotificationsCount = 0
    
    private var initialNotificationsSent = false
    
    init(dataStore: DataStore, userStore: UserStore) {
        self.dataStore = dataStore
        self.userStore = userStore
        dataStore.profileViewModel = self
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
    
    func updateTriggered() {
        if let vc = vc {
            vc.rotateRefreshButton()
        }
    }
    
    private func subscribeToNotificationsCount() {
        dataStore.notificationsManager.notificationDataObservable.subscribe(onNext: { [weak self] data in
            self?.currentNotificationsCount = data.count
            self?.vc?.notificationsCountIcon.updateDisplayCount(newVal: self?.currentNotificationsCount ?? 0)
        }).disposed(by: disposeBag)
    }
}
