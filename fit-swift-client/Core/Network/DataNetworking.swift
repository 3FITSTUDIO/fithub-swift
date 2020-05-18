//
//  DataNetworking.swift
//  fit-swift-client
//
//  Created by admin on 25/04/2020.
//  Copyright © 2020 Dominik Urbaez Gomez. All rights reserved.
//

import Foundation
import Alamofire

final class DataNetworking : NetworkingClient {
    weak var store: DataStore?
    
    enum EndpointDataType: String {
        case weights = "/weights"
        case calories = "/calories"
        case trainings = "/trainings"
        case sleep = "/sleep"
        case pulse = "/pulse"
        case steps = "/steps"
        case measurements = "/measurements"
    }
    
    // MARK: GET: Dashboard View Controller, Fetching data
    func fetchRegularData(forUserId id: Int, dataType: EndpointDataType, onComplete: @escaping(Swift.Result<[Record], NetworkError>) -> Void) {
        var record: Record?
        var records = [Record]()
        var params: [String: Any] = [:]
        params["userId"] = id
        
        let endpoint = dataType.rawValue
        executeRequest(endpoint, .get, parameters: params) { (json, error) in
            if let error = error {
                debugPrint(error.localizedDescription)
                debugPrint("fetch_" + endpoint + "_data: Received error from server")
                onComplete(.failure(.serverConnectionError))
            }
            else if let json = json {
                do {
                    try json.forEach {
                        record = try Record(json: $0)
                        if let recordUnwrapped = record {
                            records.append(recordUnwrapped)
                        }
                    }
                } catch (let error) {
                    debugPrint("fetch_" + endpoint + "_data: Failed to deserialize incoming data")
                    debugPrint(error)
                }
                onComplete(.success(records))
            }
        }
    }
    
    func fetchBodyMeasurementsData(forUserId id: Int, dataType: EndpointDataType, onComplete: @escaping(Swift.Result<[BodyMeasurements], NetworkError>) -> Void) {
        var record: BodyMeasurements?
        var records = [BodyMeasurements]()
        var params: [String: Any] = [:]
        params["userId"] = id
        
        let endpoint = dataType.rawValue
        executeRequest(endpoint, .get, parameters: params) { (json, error) in
            if let error = error {
                debugPrint(error.localizedDescription)
                debugPrint("fetch_" + endpoint + "_data: Received error from server")
                onComplete(.failure(.serverConnectionError))
            }
            else if let json = json {
                do {
                    try json.forEach {
                        record = try BodyMeasurements(json: $0)
                        if let recordUnwrapped = record {
                            records.append(recordUnwrapped)
                        }
                    }
                } catch {
                    debugPrint("fetch_" + endpoint + "_data: Failed to deserialize incoming data")
                }
                onComplete(.success(records))
            }
        }
    }
    
    // MARK: POST: Steps data
    func postStepsData(_ steps: Int, forId userId: Int, onComplete: @escaping(Bool) -> Void) {
        let date = FitHubDateFormatter.formatDate(Date.init())
        var params: [String: Any] = [:]
        params["userId"] = userId
        params["date"] = date
        params["value"] = steps
        
        let endpoint = EndpointDataType.steps.rawValue
        executeRequest(endpoint, .post, parameters: params, encoding: JSONEncoding.default) { (json, error) in
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
    
    func postRegularData(type: DataProvider.DataType, value: Float, date: String, userId: Int, onComplete: @escaping(Bool) -> Void) {
        let date = FitHubDateFormatter.formatDate(Date.init())
        var params: [String: Any] = [:]
        params["userId"] = userId
        params["date"] = date
        params["value"] = value
        
        var endpoint = ""
        switch type {
        case .weights:
            endpoint = EndpointDataType.weights.rawValue
        case .kcal:
             endpoint = EndpointDataType.calories.rawValue
        case .training:
             endpoint = EndpointDataType.trainings.rawValue
        case .sleep:
            endpoint = EndpointDataType.sleep.rawValue
        case .pulse:
             endpoint = EndpointDataType.pulse.rawValue
        case .steps:
             endpoint = EndpointDataType.steps.rawValue
        case .measurements:
             endpoint = EndpointDataType.measurements.rawValue
        }
        
        executeRequest(endpoint, .post, parameters: params, encoding: JSONEncoding.default) { (json, error) in
            if let error = error {
                debugPrint("SERVER_ERROR: Failed to post \(endpoint) data to server")
                debugPrint(error.localizedDescription)
                onComplete(false)
            }
            else {
                onComplete(true)
            }
        }
    }
    
    func postBodyData(values: [Float], forId userId: Int, onComplete: @escaping(Bool) -> Void) {
        let date = FitHubDateFormatter.formatDate(Date.init())
        var params: [String: Any] = [:]
        params["userId"] = userId
        params["date"] = date
        params["values"] = values
        
        let endpoint = EndpointDataType.measurements.rawValue
        executeRequest(endpoint, .post, parameters: params, encoding: JSONEncoding.default) { (json, error) in
            if let error = error {
                debugPrint("post_body_measurements_data: Received error from server")
                debugPrint(error.localizedDescription)
                onComplete(false)
            }
            else {
                onComplete(true)
            }
        }
    }
    
    
}
