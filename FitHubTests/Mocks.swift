//
//  Mocks.swift
//  FitHubTests
//
//  Created by admin on 22/05/2020.
//  Copyright © 2020 Dominik Urbaez Gomez. All rights reserved.
//

import Foundation
@testable import FitHub

class Mocks {
    static func RecordMock(value: Int = 10) -> Record? {
        var record: Record
        do {
            var json = [String: Any]()
            json["id"] = 1
            json["userId"] = 2
            json["date"] = "15/04/2020"
            json["value"] = value
            record = try Record(json: json)
        } catch {
            return nil
        }
        return record
    }
    
    static func BodyMeasurementsMock() -> BodyMeasurements? {
        var record: BodyMeasurements
        do {
            var json = [String: Any]()
            json["id"] = 1
            json["userId"] = 2
            json["date"] = "15/04/2020"
            let values: [Float] = [12,13,14,15,16,17,18,11] // explicit typing
            json["values"] = values
            record = try BodyMeasurements(json: json)
        } catch {
            return nil
        }
        return record
    }
    
    static func FithubNotificationMock(message: String = "default mock message") -> FithubNotification? {
        var notification: FithubNotification
        do {
            var json = [String: Any]()
            json["id"] = 1
            json["userId"] = 2
            json["date"] = "15/04/2020"
            json["message"] = message
            notification = try FithubNotification(json: json)
        } catch {
            return nil
        }
        return notification
    }
    
    static func DataStoreMock() -> DataStore {
        let store = DataStore()
        store.initialConfigComplete = true
        store.weightData = [Record]()
        for _ in 0...5 {
            if let record = RecordMock() {
                store.weightData.append(record)
            }
        }
        store.caloriesData = [Record]()
        for _ in 0...5 {
            if let record = RecordMock() {
                store.caloriesData.append(record)
            }
        }
        store.trainingData = [Record]()
        for _ in 0...5 {
            if let record = RecordMock() {
                store.trainingData.append(record)
            }
        }
        store.sleepData = [Record]()
        for _ in 0...5 {
            if let record = RecordMock() {
                store.sleepData.append(record)
            }
        }
        store.pulseData = [Record]()
        for _ in 0...5 {
            if let record = RecordMock() {
                store.pulseData.append(record)
            }
        }
        store.stepsData = [Record]()
        for _ in 0...5 {
            if let record = RecordMock() {
                store.stepsData.append(record)
            }
        }
        store.measurementsData = [BodyMeasurements]()
        for _ in 0...5 {
            if let record = BodyMeasurementsMock() {
                store.measurementsData.append(record)
            }
        }
        return store
    }
    
    static func UserStoreMock() -> UserStore {
        let store = UserStore()
        return store
    }
}
