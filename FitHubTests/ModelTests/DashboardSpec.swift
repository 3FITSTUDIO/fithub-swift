//
//  DashboardSpecs.swift
//  FitHubTests
//
//  Created by admin on 22/05/2020.
//  Copyright © 2020 Dominik Urbaez Gomez. All rights reserved.
//

import Quick
import Nimble
import Foundation
@testable import FitHub

class DashboardSpecs: QuickSpec {
    override func spec() {
        var dataStoreMock: DataStore!
        var userStoreMock: UserStore!
        var viewModel: DashboardViewModel!
        describe("Dashboard View Model Tests") {
            context("provides correct values to display in view controller") {
                afterEach {
                    dataStoreMock = nil
                    userStoreMock = nil
                    viewModel = nil
                }
                beforeEach {
                    dataStoreMock = Mocks.DataStoreMock()
                    userStoreMock = Mocks.UserStoreMock()
                    viewModel = DashboardViewModel(dataStore: dataStoreMock, userStore: userStoreMock)
                }
                it("provides correct average value for steps data") {
                    let stepsValue = viewModel.provideStepsAvgRecord()
                    expect(stepsValue).to(equal("10"))
                }
                it("provides correct average value for pulse data") {
                    let pulseValue = viewModel.providePulseAvgRecord()
                    expect(pulseValue).to(equal("10"))
                }
                it("provides correct value for other record data types") {
                    let weightValue = viewModel.provideLastRecord(dataType: .weight)
                    let caloriesValue = viewModel.provideLastRecord(dataType: .calories)
                    let trainingValue = viewModel.provideLastRecord(dataType: .training)
                    let sleepValue = viewModel.provideLastRecord(dataType: .sleep)
                    let pulseValue = viewModel.provideLastRecord(dataType: .pulse)
                    let stepsValue = viewModel.provideLastRecord(dataType: .steps)
                    
                    expect(weightValue).to(equal("10"))
                    expect(caloriesValue).to(equal("10"))
                    expect(trainingValue).to(equal("10"))
                    expect(sleepValue).to(equal("10"))
                    expect(pulseValue).to(equal("10"))
                    expect(stepsValue).to(equal("10"))
                }
            }
        }
    }
}
