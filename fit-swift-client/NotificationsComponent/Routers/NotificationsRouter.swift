//
//  NotificationsRouter.swift
//  fit-swift-client
//
//  Created by admin on 18/05/2020.
//  Copyright © 2020 Dominik Urbaez Gomez. All rights reserved.
//

import Foundation
import UIKit

class NotificationsRouter: Router {
    func route(to routeID: String, from context: UIViewController, parameters: Any? = nil) {
        guard let route = NotificationsViewController.Route(rawValue: routeID) else { return }
        let vc: UIViewController
        switch route {
        case .back:
            if let presentingVC = parameters as? NotificationsViewController.PresentingVCType, presentingVC == .dashboard {
                vc = DashboardViewController()
            }
            else {
                vc = ProfileViewController()
            }
        }
        context.navigationController?.pushViewController(vc, animated: false)
    }
}
