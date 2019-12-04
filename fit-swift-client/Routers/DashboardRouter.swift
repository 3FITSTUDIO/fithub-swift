//
//  DashboardRouter.swift
//  fit-swift-client
//
//  Created by admin on 05/11/2019.
//  Copyright © 2019 Dominik Urbaez Gomez. All rights reserved.
//

import Foundation
import UIKit

class DashboardRouter: Router {
    
    func route(to routeID: String, from context: UIViewController, parameters: Any? = nil) {
        guard let route = DashboardViewController.Route(rawValue: routeID) else { return }
        let vc: UIViewController
        switch route {
        case .logout:
            vc = LoginViewController()
        }
        context.navigationController?.pushViewController(vc, animated: false)
    }
}
