//
//  ProfileRouter.swift
//  fit-swift-client
//
//  Created by admin on 18/05/2020.
//  Copyright © 2020 Dominik Urbaez Gomez. All rights reserved.
//

import Foundation
import UIKit

class ProfileRouter: Router {
    func route(to routeID: String, from context: UIViewController, parameters: Any? = nil) {
        guard let route = ProfileViewController.Route(rawValue: routeID) else { return }
        let vc: UIViewController
        switch route {
        case .logout:
            vc = LoginViewController()
        case .dashboard:
            vc = DashboardViewController()
        case .notifications:
            vc = NotificationsViewController()
        case .settings:
            if let vm = parameters as? ProfileViewModel {
                vc = SettingsViewController(viewModel: vm)
            }
            else {
                vc = SettingsViewController(viewModel: ProfileViewModel())
            }
        }
        context.navigationController?.pushViewController(vc, animated: false)
    }
}
