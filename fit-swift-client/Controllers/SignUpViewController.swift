//
//  SignUpViewController.swift
//  fit-swift-client
//
//  Created by admin on 06/11/2019.
//  Copyright © 2019 Dominik Urbaez Gomez. All rights reserved.
//

import Foundation
import UIKit
import EasyPeasy

class SignUpViewController: UIViewController {
    enum Route: String {
        case cancel
        case submit
//        case forgot
    }
    let router = SignUpRouter()
    let viewModel = SignUpViewModel()
    
    private let container = UIScrollView() // TODO: Make sure text fields autoscroll when editing began
    
    let nameField = TextField()
    let surnameField = TextField()
    let emailField = TextField()
    let passwdField = PasswordField()
    let passwdConfirmField = PasswordField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCommonTraits()
        setup()
    }
    
    private func setup(){
        view.addSubview(container)
        container.easy.layout(Edges())
        
        let logo = UIImageView()
        logo.image = UIImage(named: "logo-text")
        container.addSubview(logo)
        logo.image = ImageUtility.resizeImage(image: logo.image, toScale: 0.7)
        logo.easy.layout(CenterX(), Top(80))
        setupForm()
    }
    
    private func  setupForm() {
        let textFields = [nameField, surnameField, emailField, passwdField, passwdConfirmField]
        container.addSubviews(subviews: textFields)
        
        let nameLabel = Label(label: "name")
        let surnameLabel = Label(label: "surname")
        let emailLabel = Label(label: "email")
        let passwdLabel = Label(label: "password")
        let passwdConfirmLabel = Label(label: "confirm password")
        
        let labels = [nameLabel, surnameLabel, emailLabel, passwdLabel, passwdConfirmLabel]
        container.addSubviews(subviews: labels)
        
        nameField.easy.layout(CenterX(), Top(250))
        var previous = nameField
        let rest = [surnameField, emailField, passwdField, passwdConfirmField]
        rest.forEach {
            $0.easy.layout(CenterX(), Top(41).to(previous, .bottom))
            previous = $0
        }
        
        nameLabel.easy.layout(Left(82), Top(225))
        let rest2 = [surnameLabel, emailLabel, passwdLabel, passwdConfirmLabel]
        var previous2 = nameLabel
        rest2.forEach {
            $0.easy.layout(Left(82), Top(63).to(previous2))
            previous2 = $0
        }
        setupButtons()
    }
        
    private func setupButtons() {
        let createAccountButton = Button(type: .big, label: "create new account")
        container.addSubview(createAccountButton)
        createAccountButton.easy.layout(CenterX(), Top(40).to(passwdConfirmField, .bottom))
        createAccountButton.addGesture(target: self, selector: #selector(self.submitTapped(_:)))
        
//        let forgotPasswordButton = Label(label: "forgot password?")
//        container.addSubview(forgotPasswordButton)
//        forgotPasswordButton.easy.layout(CenterX(), Bottom(60))
//        forgotPasswordButton.addGesture(target: self, selector: #selector(self.forgotTapped(_:)))
    }
}

// MARK: Routing

extension SignUpViewController {
    
    @objc private func cancelTapped(_ sender: UITapGestureRecognizer? = nil) {
        router.route(to: Route.cancel.rawValue, from: self)
    }
    @objc private func submitTapped(_ sender: UITapGestureRecognizer? = nil) {
        router.route(to: Route.submit.rawValue, from: self)
    }
//    @objc private func forgotTapped(_ sender: UITapGestureRecognizer? = nil) {
//        router.route(to: Route.forgot.rawValue, from: self)
//    }
}

