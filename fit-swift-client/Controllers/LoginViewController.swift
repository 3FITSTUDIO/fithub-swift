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
    
    private func setup(){
        view.addSubview(container)
        container.easy.layout(Edges())
        
        let logo = UIImageView()
        logo.image = UIImage(named: "logo-text")
        container.addSubview(logo)
        logo.easy.layout(CenterX(), Top(100))
        
        setupButtons()
        setupTextFields()
        
    }
    
    private func setupButtons() {
        let loginButton = Button(label: "login")
        container.addSubview(loginButton)
        loginButton.easy.layout(CenterX(), Bottom(280))
        loginButton.addGesture(target: self, selector: #selector(self.loginButtonTapped(_:)))
        
        let newAccButton = Button(type: .big, label: "create new account")
        container.addSubview(newAccButton)
        newAccButton.easy.layout(CenterX(), Bottom(125))
        newAccButton.addGesture(target: self, selector: #selector(self.signUpTapped(_:)))
        
        let forgotButton = Button(type: .label, label: "forgot password?")
        container.addSubview(forgotButton)
        forgotButton.easy.layout(CenterX(), Top(15).to(loginButton))
        forgotButton.addGesture(target: self, selector: #selector(self.forgotPasswordTapped(_:)))
    }
    
    private func  setupTextFields() {
    
    }

}

// MARK: Routing

extension LoginViewController {

        @objc private func loginButtonTapped(_ sender: UITapGestureRecognizer? = nil) {
            router.route(to: Route.login.rawValue, from: self)
        }
        @objc private func signUpTapped(_ sender: UITapGestureRecognizer? = nil) {
            router.route(to: Route.signUp.rawValue, from: self)
        }
        @objc private func forgotPasswordTapped(_ sender: UITapGestureRecognizer? = nil) {
            router.route(to: Route.forgotPassword.rawValue, from: self)
        }
}

