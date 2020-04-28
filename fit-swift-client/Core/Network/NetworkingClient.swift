//
//  NetworkingClient.swift
//  fit-swift-client
//
//  Created by admin on 05/12/2019.
//  Copyright © 2019 Dominik Urbaez Gomez. All rights reserved.
//

import Foundation
import Alamofire

class NetworkingClient {
    enum NetworkError: Error {
        case dataNotAvailable
        case cannotProcessData
        case serverConnectionError
    }
    
    let urlBase = "http://localhost:8080"
//    let urlBase = "http://08a218ed.ngrok.io"
    
    typealias WebServiceResponse = ([[String: Any]]?, Error?) -> Void
    
    public func executeRequest(_ endpoint: String, _ method: HTTPMethod, parameters: Parameters? = nil, onComplete: @escaping WebServiceResponse) {
        let url = urlBase + endpoint
        
        Alamofire.request(url, method: method, parameters: parameters).responseJSON { (response) in
            if let error = response.error {
                onComplete(nil, error)
            }
            else if let jsonArray = response.result.value as? [[String: Any]] {
                onComplete(jsonArray, nil)
            }
            else if let jsonDict = response.result.value as? [String: Any] {
                onComplete([jsonDict], nil)
            }
        }
    }
}
