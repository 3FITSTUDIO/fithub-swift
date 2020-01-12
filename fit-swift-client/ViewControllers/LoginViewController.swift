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
//        case forgotPassword
    }
    private let router = LoginRouter()
    private let viewModel = LoginViewModel()
    
    private let loginField = TextField()
    private let passwordField = PasswordField()
    private let loginLabel = Label(label: "login")
    private let passwordLabel = Label(label: "password")
    
    private let container = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCommonTraits()
        setup()
        resetAppearance()
    }
    
    private func setup(){
        view.addSubview(container)
        container.easy.layout(Edges())
        
        setupButtons()
        setupTextFields()
        let logo = UIImageView()
        logo.image = UIImage(named: "logo-text")
        container.addSubview(logo)
        logo.easy.layout(CenterX(), Bottom(20).to(loginLabel))
        
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
//        container.addSubview(forgotButton)
        forgotButton.easy.layout(CenterX(), Top(15).to(loginButton))
//        forgotButton.addGesture(target: self, selector: #selector(self.forgotPasswordTapped(_:)))
    }
    
    private func  setupTextFields() {
        container.addSubviews(subviews: [loginLabel, passwordLabel, loginField, passwordField])
        loginLabel.easy.layout(Bottom(6).to(loginField), Left(78))
        passwordLabel.easy.layout(Bottom(6).to(passwordField), Left(78))
        loginField.easy.layout(CenterX(), Bottom(425))
        passwordField.easy.layout(CenterX(), Bottom(345))
    }
    
    func resetAppearance() {
        loginLabel.text = "login"
        loginField.textField.text = ""
        passwordLabel.text = "password"
        passwordField.textField.text = ""
    }
}

// MARK: Routing

extension LoginViewController {

        @objc private func loginButtonTapped(_ sender: UITapGestureRecognizer? = nil) {
            let login = loginField.textField.text
            let passwd = passwordField.textField.text
            
            if viewModel.authenticate(login: login, passwd: passwd){
                router.route(to: Route.login.rawValue, from: self)
            }
            else {
                loginField.textField.text = ""
                passwordField.textField.text = ""
                loginLabel.text = "try again! - login"
                passwordLabel.text = "try again! - password"
            }
            return
        }
        @objc private func signUpTapped(_ sender: UITapGestureRecognizer? = nil) {
            router.route(to: Route.signUp.rawValue, from: self)
        }
//        @objc private func forgotPasswordTapped(_ sender: UITapGestureRecognizer? = nil) {
//            router.route(to: Route.forgotPassword.rawValue, from: self)
//        }
}

