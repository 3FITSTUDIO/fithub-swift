//
//  UserModelSpecs.swift
//  FitHubTests
//
//  Created by admin on 22/05/2020.
//  Copyright © 2020 Dominik Urbaez Gomez. All rights reserved.
//

import Quick
import Nimble
import Foundation
@testable import FitHub

class UserModelSpecs: QuickSpec {
    override func spec() {
        var record: User!
        describe("User Model Tests") {
            context("Can be created with valid JSON") {
                afterEach {
                    record = nil
                }
                beforeEach {
                    do {
                        var json = [String: Any]()
                        json["id"] = 1
                        json["first_name"] = "Dominik"
                        json["last_name"] = "Gomez"
                        json["email"] = "dominik@gmail.com"
                        json["login"] = "dominik1"
                        json["password"] = "dominik123"
                        json["sex"] = "M"
                        json["height"] = 181
                        json["yearOfBirth"] = 1997
                        record = try User(json: json)
                    } catch {
                        fail("Problem parsing JSON")
                    }
                }
                it("can parse the correct id") {
                    expect(record.id).to(equal(1))
                }
                it("can parse the correct firstName") {
                    expect(record.firstName).to(equal("Dominik"))
                }
                it("can parse the correct lastName") {
                    expect(record.lastName).to(equal("Gomez"))
                }
                it("can parse the correct email") {
                    expect(record.email).to(equal("dominik@gmail.com"))
                }
                it("can parse the correct login") {
                    expect(record.login).to(equal("dominik1"))
                }
                it("can parse the correct password") {
                    expect(record.password).to(equal("dominik123"))
                }
                it("can parse the correct sex") {
                    expect(record.sex).to(equal("M"))
                }
                it("can parse the correct height") {
                    expect(record.height).to(equal(181))
                }
                it("can parse the correct yearOfBirth") {
                    expect(record.yearOfBirth).to(equal(1997))
                }
                it("can calculate the correct age") {
                    expect(record.age).to(equal(23))
                }
            }
        }
    }
}

