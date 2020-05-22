//
//  DataStoreSpecs.swift
//  FitHubTests
//
//  Created by admin on 22/05/2020.
//  Copyright © 2020 Dominik Urbaez Gomez. All rights reserved.
//

import Quick
import Nimble
import Foundation
@testable import FitHub

class DataStoreSpecs: QuickSpec {
    override func spec() {
        var dataStoreMock: DataStore!
        var userStoreMock: UserStore!
        describe("Data Store Tests") {
            context("Correctly manage stored data") {
                afterEach {
                    dataStoreMock = nil
                    userStoreMock = nil
                }
                beforeEach {
                    dataStoreMock = Mocks.DataStoreMock()
                    userStoreMock = Mocks.UserStoreMock()
                }
                it("should clear all stored data on clearData") {
                    let profileViewModel = ProfileViewModel(dataStore: dataStoreMock, userStore: userStoreMock)
                    profileViewModel.clearProfileOnLogout()
                    
                    expect(dataStoreMock.weightData).to(equal([Record]()))
                    expect(dataStoreMock.caloriesData).to(equal([Record]()))
                    expect(dataStoreMock.trainingData).to(equal([Record]()))
                    expect(dataStoreMock.sleepData).to(equal([Record]()))
                    expect(dataStoreMock.pulseData).to(equal([Record]()))
                    expect(dataStoreMock.stepsData).to(equal([Record]()))
                    expect(dataStoreMock.measurementsData).to(equal([BodyMeasurements]()))
                }
            }
        }
    }
}
