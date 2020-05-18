//
//  NotificationsNetworking.swift
//  fit-swift-client
//
//  Created by admin on 18/05/2020.
//  Copyright © 2020 Dominik Urbaez Gomez. All rights reserved.
//

import Foundation
import Alamofire

class NotificationsNetworking: NetworkingClient {
    
    let notificationsEndpoint = "/notifications"
    
    func fetchAllUserNotifications(forUserId id: Int, onComplete: @escaping(Swift.Result<[FithubNotification], NetworkError>) -> Void) {
        var notification: FithubNotification?
        var notifications = [FithubNotification]()
        var params: [String: Any] = [:]
        params["userId"] = id
        
        let endpoint = notificationsEndpoint
        executeRequest(endpoint, .get, parameters: params) { (json, error) in
            if let error = error {
                debugPrint(error.localizedDescription)
                debugPrint("fetch_" + endpoint + "_data: Received error from server")
                onComplete(.failure(.serverConnectionError))
            }
            else if let json = json {
                do {
                    try json.forEach {
                        notification = try FithubNotification(json: $0)
                        if let notificationUnwrapped = notification {
                            notifications.append(notificationUnwrapped)
                        }
                    }
                } catch (let error) {
                    debugPrint("fetch_" + endpoint + "_data: Failed to deserialize incoming data")
                    debugPrint(error)
                }
                onComplete(.success(notifications))
            }
        }
    }
    
    func deleteNotification(id: Int, onComplete: @escaping(Bool) -> Void) {
        let endpoint = notificationsEndpoint + "/\(id)"
        executeRequest(endpoint, .delete, parameters: nil) { (json, error) in
            if let error = error {
                debugPrint(error.localizedDescription)
                debugPrint("delete_" + endpoint + "_data: Received error from server")
                onComplete(false)
            }
            else {
                debugPrint("Successfully deleted notification.")
                onComplete(true)
            }
        }
    }
}
