//
//  WelcomeRouter.swift
//  fit-swift-client
//
//  Created by admin on 09/10/2019.
//  Copyright © 2019 Dominik Urbaez Gomez. All rights reserved.
//

import Foundation
import UIKit

class WelcomeRouter: Router {
    unowned var viewModel: WelcomeViewModel
    init(viewModel: WelcomeViewModel) {
        self.viewModel = viewModel
    }
    func route(
        to routeID: String,
        from context: UIViewController,
        parameters: Any?)
    {
        guard let route = WelcomeViewController.Route(rawValue: routeID) else {
            return
        }
//        switch route {
//        case .login:
//            if viewModel.shouldChangePassword {
//                // Push change-password-screen.
//            } else {
//                // Push home-screen.
//            }
//        case .signUp:
//            // Push sign-up-screen:
//            let vc = SignUpViewController()
//            let vm = SignUpViewModel()
//            vc.viewModel = vm
//            vc.router = SignUpRouter(viewModel: vm)
//            context.navigationController.push(vc, animated: true)
//        case .forgotPasswordScreen:
//            // Push forgot-password-screen.
//        }
    }
}
