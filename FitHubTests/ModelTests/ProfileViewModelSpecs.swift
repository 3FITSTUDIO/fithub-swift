//
//  ProfileViewModelSpecs.swift
//  FitHubTests
//
//  Created by admin on 22/05/2020.
//  Copyright © 2020 Dominik Urbaez Gomez. All rights reserved.
//

import Quick
import Nimble
import Foundation
@testable import FitHub

class ProfileViewModelSpecs: QuickSpec {
    override func spec() {
        var dataStoreMock: DataStore!
        var userStoreMock: UserStore!
        var profileViewModel: ProfileViewModel!
        describe("ProfileViewModel Tests") {
            afterEach {
                dataStoreMock = nil
                userStoreMock = nil
                profileViewModel = nil
            }
            beforeEach {
                dataStoreMock = Mocks.DataStoreMock()
                userStoreMock = Mocks.UserStoreMock()
                
                dataStoreMock.notificationsManager.notificationData = [
                    Mocks.FithubNotificationMock(message: "message1")!,
                    Mocks.FithubNotificationMock(message: "message2")!,
                    Mocks.FithubNotificationMock(message: "message3")!
                ]
                profileViewModel = ProfileViewModel(dataStore: dataStoreMock, userStore: userStoreMock)
            }
            context("Update data upon received value") {
                it("should update the notification count when a new value notifications array is saved") {
                    expect(profileViewModel.currentNotificationsCount).to(equal(3))
                    dataStoreMock.notificationsManager.notificationData.append(Mocks.FithubNotificationMock(message: "message4")!)
                    expect(profileViewModel.currentNotificationsCount).toEventually(equal(4))
                }
            }
        }
    }
}
