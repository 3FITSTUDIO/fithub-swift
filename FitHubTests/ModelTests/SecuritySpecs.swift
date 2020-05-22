//
//  SecuritySpecs.swift
//  FitHubTests
//
//  Created by admin on 22/05/2020.
//  Copyright © 2020 Dominik Urbaez Gomez. All rights reserved.
//

import Quick
import Nimble
import Foundation
@testable import FitHub

class SecuritySpecs: QuickSpec {
    override func spec() {
        describe("Security Tests") {
            context("Correctly hash strings") {
                it("should hash the given string correctly") {
                    let stringRaw = "a string"
                    let hashedString = Security.sha256(str: stringRaw).uppercased()
                    let expectation = "C0DC86EFDA0060D4084098A90EC92B3D4AA89D7F7E0FBA5424561D21451E1758"
                    expect(hashedString).to(equal(expectation))
                }
            }
        }
    }
}
