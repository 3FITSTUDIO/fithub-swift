//
//  DataSourceViewModel.swift
//  fit-swift-client
//
//  Created by admin on 28/04/2020.
//  Copyright © 2020 Dominik Urbaez Gomez. All rights reserved.
//

import Foundation

protocol DataSourceViewModel {
    var vc: RecordsTableViewViewController? { get set }
    var store: DataStore?  { get }
    var data: [Record]  { get }
    func fetchDataForCell(forIndex index: Int) -> Record
}
