//
//  ProgressRouter.swift
//  fit-swift-client
//
//  Created by admin on 18/01/2020.
//  Copyright © 2020 Dominik Urbaez Gomez. All rights reserved.
//

import Foundation
import UIKit

class ChartRouter: Router {
    func route(to routeID: String, from context: UIViewController, parameters: Any? = nil) {
        guard let route = ChartViewController.Route(rawValue: routeID) else { return }
        let vc: UIViewController
        switch route {
        case .back:
            vc = DashboardViewController()
        }
        context.navigationController?.pushViewController(vc, animated: false)
    }
}
