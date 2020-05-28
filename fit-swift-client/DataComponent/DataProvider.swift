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
        case training = "Training"
        case sleep = "Sleep"
        case pulse = "Pulse"
        case steps = "Steps"
        case measurements = "Measurements"
    }
    
    // provides VC with right VM for Dashboard Router
    func provideViewController(dataType: DataType) -> RecordsTableViewViewController {
        var viewModel: DataSourceViewModel
        switch dataType {
        case .weights:
            viewModel = WeightsViewModel()
        case .kcal:
            viewModel = CaloriesViewModel()
        case .sleep:
            viewModel = SleepViewModel()
        case .training:
            viewModel = TrainingsViewModel()
        case .pulse:
            viewModel = PulseViewModel()
        case .steps:
            viewModel = StepsViewModel()
        case .measurements:
            viewModel = MeasurementsViewModel()
        }
        let vc = RecordsTableViewViewController(viewModel: viewModel, dataType: dataType)
        return vc
    }
}
