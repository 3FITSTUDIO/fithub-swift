//
//  DataNetworking.swift
//  fit-swift-client
//
//  Created by admin on 25/04/2020.
//  Copyright © 2020 Dominik Urbaez Gomez. All rights reserved.
//

import Foundation
import Alamofire

class DataNetworking : NetworkingClient {
    
    weak var store: DataStore?
    private var endpointSteps = "/steps"
    private var endpointWeights = "/weights"
    
    override init() {
        super.init()
        stubWeightArray()
        stubCaloriesArray()
    }
    
    // MARK: GET: Dashboard View Controller, Fetching all data
    func fetchWeightData(forUserId id: Int) -> [Record] {
//        return weightArray // STUB FOR TESTING
        var record: Record?
        var records = [Record]()
        var params: [String: Any] = [:]
        params["userId"] = id
        
        executeRequest(endpointWeights, .get) { (json, error) in
            if let error = error {
                debugPrint(error.localizedDescription)
                debugPrint("fetch_user_data: Received error from server")
            }
            else if let json = json {
                do {
                    try json.forEach {
                        record = try Record(json: $0)
                        if let recordUnwrapped = record {
                            records.append(recordUnwrapped)
                        }
                    }
                } catch {
                    debugPrint("fetch_user_data: Failed to deserialize incoming data")
                }
            }
        }
        return records
    }
    
    func fetchCaloriesData(forUserId id: Int) -> [Record] {
        return caloriesArray // STUB FOR TESTING
        
        //        let url = urlCalories + "/" + String(id)
        //        var record: Record?
        //        var records = [Record]()
        //
        //        executeRequest(url, .get) { (json, error) in
        //            if let error = error {
        //                debugPrint(error.localizedDescription)
        //                debugPrint("fetch_user_data: Received error from server")
        //            }
        //            else if let json = json {
        //                do {
        //                    try json.forEach {
        //                        record = try Record(json: $0)
        //                        if let recordUnwrapped = record {
        //                            records.append(recordUnwrapped)
        //                        }
        //                    }
        //                } catch {
        //                    debugPrint("fetch_user_data: Failed to deserialize incoming data")
        //                }
        //            }
        //        }
        //        return records
    }
    
    
    // MARK: POST: Steps data
    
    func postStepsData(_ steps: Int, forId userId: Int, onComplete: @escaping(Bool) -> Void) {
        let date = FitHubDateFormatter.formatDate(Date.init())
        var params: [String: Any] = [:]
        params["userId"] = userId
        params["date"] = date
        params["value"] = steps
        
        executeRequest(endpointSteps, .post, parameters: params) { (json, error) in
            if let error = error {
                debugPrint("post_steps_data: Received error from server")
                debugPrint(error.localizedDescription)
                onComplete(false)
            }
            else {
                onComplete(true)
            }
        }
    }
    
    // MARK: Add New Value View Controller
    
    //    func postNewWeightsRecord(value: Int, date: Date) -> Bool {
    //        let url = urlWeights
    //        var params: [String: Any] = [:]
    //        params["value"] = value
    //        params["date"] = FitHubDateFormatter.formatDate(date)
    //
    //        var success = false
    //        executeRequest(url, .post, parameters: params) { (json, error) in
    //            if let error = error {
    //                debugPrint(error.localizedDescription)
    //                debugPrint("fetch_user_id: Received error from server")
    //            }
    //            else {
    //                success = true
    //            }
    //        }
    //        return success
    //    }
    
    //    func postNewCaloriesRecord(value: Int, date: Date) -> Bool {
    //        let url = urlCalories
    //        var params: [String: Any] = [:]
    //        params["value"] = value
    //        params["date"] = FitHubDateFormatter.formatDate(date)
    //
    //        var success = false
    //        executeRequest(url, .post, parameters: params) { (json, error) in
    //            if let error = error {
    //                debugPrint(error.localizedDescription)
    //                debugPrint("fetch_user_id: Received error from server")
    //            }
    //            else {
    //                success = true
    //            }
    //        }
    //        return success
    //    }
    
    // MARK: STUBS
    var weightArray = [Record]()
    private func stubWeightArray() {
        for i in 1...31 {
            let randWeight = Int.random(in: 95...99)
            weightArray.append(Record(id: i, userId: 1, value: randWeight, date: FitHubDateFormatter.formatDate(Date.distantPast)))
        }
    }
    var caloriesArray = [Record]()
    private func stubCaloriesArray() {
        for i in 1...31 {
            let randWeight = Int.random(in: 2300...3000)
            caloriesArray.append(Record(id: i, userId: 1, value: randWeight, date: FitHubDateFormatter.formatDate(Date.distantPast)))
        }
    }
}
