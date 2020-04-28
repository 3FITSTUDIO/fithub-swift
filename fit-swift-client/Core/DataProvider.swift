//
//  DataProvider.swift
//  fit-swift-client
//
//  Created by admin on 28/04/2020.
//  Copyright © 2020 Dominik Urbaez Gomez. All rights reserved.
//

import Foundation

class DataProvider {
    enum DataType: String {
        case weights = "Weights"
        case kcal = "Calories"
    }
    
    // provides VC with right VM for Dashboard Router
    func provideViewController(dataType: DataType) -> RecordsTableViewViewController {
        var viewModel: DataSourceViewModel
        switch dataType {
        case .weights:
            viewModel = WeightsViewModel()
        case .kcal:
            viewModel = CaloriesViewModel()
        }
        let vc = RecordsTableViewViewController(viewModel: viewModel, componentName: dataType.rawValue)
        return vc
    }
}
