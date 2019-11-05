//
//  LoginRouter.swift
//  fit-swift-client
//
//  Created by admin on 09/10/2019.
//  Copyright © 2019 Dominik Urbaez Gomez. All rights reserved.
//

import Foundation
import UIKit

class LoginRouter: Router {
    
    func route(to routeID: String, from context: UIViewController, parameters: Any? = nil) {
        guard let route = LoginViewController.Route(rawValue: routeID) else { return }
        switch route {
        case .login:
            let vc = DashboardViewController()
            context.present(vc, animated: true, completion: nil)
        case .signUp:
            print("SIGN UP")
        case .forgotPassword:
             print("FORGOT PASSWORD")
        }
    }
}
