//
//  ValidationSpecs.swift
//  FitHubTests
//
//  Created by admin on 22/05/2020.
//  Copyright © 2020 Dominik Urbaez Gomez. All rights reserved.
//

import Quick
import Nimble
import Foundation
@testable import FitHub

class ValidationSpecs: QuickSpec {
    override func spec() {
        describe("Record Model Tests") {
            context("Can be created with valid JSON") {
                it("can validate names correctly") {
                    let name1 = ""
                    let name2 = "Dominik"
                    let result1 = Validation.validateName(name: name1)
                    let result2 = Validation.validateName(name: name2)
                    expect(result1).to(beFalse())
                    expect(result2).to(beTrue())
                }
                it("can validate emails correctly") {
                    let email1 = ""
                    let email2 = "dominik@gmail.com"
                    let result1 = Validation.validateEmailId(emailID: email1)
                    let result2 = Validation.validateEmailId(emailID: email2)
                    expect(result1).to(beFalse())
                    expect(result2).to(beTrue())
                }
                it("can validate passwords correctly") {
                    let password1 = ""
                    let password2 = "dominik"
                    let password3 = "dominik123"
                    
                    let result1 = Validation.validatePassword(password: password1)
                    let result2 = Validation.validatePassword(password: password2)
                    let result3 = Validation.validatePassword(password: password3)
                    
                    expect(result1).to(beFalse())
                    expect(result2).to(beFalse())
                    expect(result3).to(beTrue())
                }
            }
        }
    }
}
