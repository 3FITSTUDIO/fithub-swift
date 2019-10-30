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
            print("SUCCESSFULLY LOGGED IN")
//        case .signUp:
//            // Push sign-up-screen:
//            let vc = SignUpViewController()
//            let vm = SignUpViewModel()
//            vc.viewModel = vm
//            vc.router = SignUpRouter(viewModel: vm)
//            context.navigationController.push(vc, animated: true)
//        case .forgotPasswordScreen:
            // Push forgot-password-screen.
        default:
            return
        }
    }
}
