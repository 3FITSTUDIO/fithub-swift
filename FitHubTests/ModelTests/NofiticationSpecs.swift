//
//  NotificationSpecs.swift
//  FitHubTests
//
//  Created by admin on 23/05/2020.
//  Copyright © 2020 Dominik Urbaez Gomez. All rights reserved.
//

import Quick
import Nimble
import Foundation
@testable import FitHub

class NotificationSpecs: QuickSpec {
    override func spec() {
        var record: FithubNotification!
        describe("Body Measurements Model Tests") {
            context("Can be created with valid JSON") {
                afterEach {
                    record = nil
                }
                beforeEach {
                    do {
                        var json = [String: Any]()
                        json["id"] = 1
                        json["userId"] = 2
                        json["date"] = "15/04/2020"
                        json["message"] = "test message"
                        record = try FithubNotification(json: json)
                    } catch {
                        fail("Problem parsing JSON")
                    }
                }
                it("can parse the correct id") {
                    expect(record.id).to(equal(1))
                }
                it("can parse the correct userId") {
                    expect(record.userId).to(equal(2))
                }
                it("can parse the correct date") {
                    expect(record.date).to(equal("15/04/2020"))
                }
                it("can parse the correct message") {
                    expect(record.message).to(equal("test message"))
                }
                it("sets the correct isGlobal value") {
                    expect(record.isGlobal).to(beTrue())
                }
            }
        }
    }
}
