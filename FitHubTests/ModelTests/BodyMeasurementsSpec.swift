//
//  BodyMeasurementsSpecs.swift
//  FitHubTests
//
//  Created by admin on 22/05/2020.
//  Copyright © 2020 Dominik Urbaez Gomez. All rights reserved.
//

import Quick
import Nimble
import Foundation
@testable import FitHub

class BodyMeasurementsSpecs: QuickSpec {
    override func spec() {
        var record: BodyMeasurements!
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
                        let values: [Float] = [11,11,11,11,11,11,11,11] // explicit typing
                        json["values"] = values
                        record = try BodyMeasurements(json: json)
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
                it("can parse the correct values") {
                    expect(record.values).to(equal([11,11,11,11,11,11,11,11]))
                }
            }
        }
    }
}
