//
//  UserLogicTests.swift
//  FitHubTests
//
//  Created by admin on 22/05/2020.
//  Copyright © 2020 Dominik Urbaez Gomez. All rights reserved.
//

import XCTest
@testable import FitHub

class UserLogicTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDataVerificationOnSignUp() {
        let signUpViewModel = SignUpViewModel()
        let enteredDataEmptyStrings = ["","","","","","","","",""]
        XCTAssertEqual(signUpViewModel.verifyEnteredData(enteredDataEmptyStrings), SignupViewController
    }
}
