//
//  WelcomeViewController.swift
//  fit-swift-client
//
//  Created by admin on 08/10/2019.
//  Copyright © 2019 Dominik Urbaez Gomez. All rights reserved.
//

import UIKit
import EasyPeasy

class WelcomeViewController: UIViewController {
    enum Route: String {
        case login
        case signUp
        case forgotPassword
    }
//    var viewModel: LoginViewModel!
    var router: Router!
    
    private let container = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup(){
        view.addSubview(container)
        container.easy.layout(Edges())
        container.backgroundColor = .blue
    }

}

// MARK: Routing

extension WelcomeViewController {

//        func loginButtonTapped() {
//            router.route(to: Route.login.rawValue, from: self)
//        }
//        func signUpTapped() {
//            router.route(to: Route.signUp.rawValue, from: self)
//        }
//        func forgotPasswordTapped() {
//            router.route(to: Route.forgotPassword.rawValue, from: self)
//        }
}

