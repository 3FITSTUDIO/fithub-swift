//
//  SignUpRouter.swift
//  fit-swift-client
//
//  Created by admin on 06/11/2019.
//  Copyright © 2019 Dominik Urbaez Gomez. All rights reserved.
//

import Foundation
import UIKit

class SignUpRouter : Router {
    
    func route(to routeID: String, from context: UIViewController, parameters: Any? = nil) {
        guard let route = SignUpViewController.Route(rawValue: routeID) else { return }
        let vc: UIViewController
        switch route {
        case .cancel:
            vc = LoginViewController()
            //TODO: pass newAccountCreated = false
        case .submit:
            vc = DashboardViewController()
            //TODO: pass newAccountCreated = true
//        case .forgot:
//            return
//            //no-op
        }
        context.navigationController?.pushViewController(vc, animated: false)
    }
}
