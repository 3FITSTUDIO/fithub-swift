//
//  SerializationError.swift
//  fit-swift-client
//
//  Created by admin on 12/01/2020.
//  Copyright © 2020 Dominik Urbaez Gomez. All rights reserved.
//

import Foundation

public enum SerializationError: Error {
    case missing(String)
    case invalid(String, Any)
}

