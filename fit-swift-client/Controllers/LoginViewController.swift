//
//  LoginViewController.swift
//  fit-swift-client
//
//  Created by admin on 08/10/2019.
//  Copyright © 2019 Dominik Urbaez Gomez. All rights reserved.
//

import UIKit
import EasyPeasy

class LoginViewController: UIViewController {
    enum Route: String {
        case login
        case signUp
        case forgotPassword
    }
    var router = LoginRouter()
    
    private let container = UIView()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setGradientBackground()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup(){
        view.addSubview(container)
        container.easy.layout(Edges())
        
        let button = Button()
        container.addSubview(button)
        button.easy.layout(Center())
        button
    }

}

// MARK: Routing

extension LoginViewController {

        func loginButtonTapped() {
            router.route(to: Route.login.rawValue, from: self)
        }
//        func signUpTapped() {
//            router.route(to: Route.signUp.rawValue, from: self)
//        }
//        func forgotPasswordTapped() {
//            router.route(to: Route.forgotPassword.rawValue, from: self)
//        }
}

