//
//  SignupValidationSpecs.swift
//  FitHubTests
//
//  Created by admin on 22/05/2020.
//  Copyright © 2020 Dominik Urbaez Gomez. All rights reserved.
//

import Quick
import Nimble
import Foundation
@testable import FitHub

class SignupValidationSpecs: QuickSpec {
    override func spec() {
        var viewModel: SignUpViewModel!
        describe("Signup Validation Tests") {
            context("validates signup entered data correctly") {
                afterEach {
                    viewModel = nil
                }
                beforeEach {
                    viewModel = SignUpViewModel()
                }
                it("does not validate empty fields") {
                    let emptyFieldsData = ["","","","","","","","",""]
                    
                    let result = viewModel.verifyEnteredData(data: emptyFieldsData)
                    expect(result).to(equal(SignUpViewModel.ValidationResult.emptyFields))
                }
                it("does not validate mismatched passwords") {
                    let mismatchedPasswordsData = ["smth","smth","smth","smth","passwd1234","passwd2345","smth","smth","smth"]
                    
                    let result = viewModel.verifyEnteredData(data: mismatchedPasswordsData)
                    expect(result).to(equal(SignUpViewModel.ValidationResult.passwordsDontMatch))
                }
                it("does not validate passwords not matching regex") {
                    let passwordNotMatchingRegexData = ["smth","smth","smth","smth","passwd","passwd","smth","smth","smth"]
                    
                    let result = viewModel.verifyEnteredData(data: passwordNotMatchingRegexData)
                    expect(result).to(equal(SignUpViewModel.ValidationResult.invalidPassword))
                }
            }
        }
    }
}
