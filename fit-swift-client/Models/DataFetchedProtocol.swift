//
//  DataFetchedProtocol.swift
//  fit-swift-client
//
//  Created by admin on 05/05/2020.
//  Copyright © 2020 Dominik Urbaez Gomez. All rights reserved.
//

import Foundation

protocol DataFetched {
    var id: Int { get set }
    var userId: Int { get set }
    var date: String { get set }
    var value: Double { get set }
    var values: [Double] { get set }
}
