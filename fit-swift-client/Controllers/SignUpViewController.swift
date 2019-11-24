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
    
    var scrollOffset : CGFloat = 0
    var distance : CGFloat = 0
    
    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.contentSize.height = 1000
        return view
    }()
    
    let nameField = TextField()
    let surnameField = TextField()
    let emailField = TextField()
    let passwdField = PasswordField()
    let passwdConfirmField = PasswordField()
    var textFields = [TextField]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCommonTraits()
        textFields = [nameField, surnameField, emailField, passwdField, passwdConfirmField]
        setup()
    }
    
    private func setup(){
        view.addSubview(scrollView)
        scrollView.easy.layout(Top(20), Bottom(20), Left(), Right())
        
        let logo = UIImageView()
        logo.image = UIImage(named: "logo-text")
        scrollView.addSubview(logo)
        logo.image = ImageUtility.resizeImage(image: logo.image, toScale: 0.7)
        logo.easy.layout(CenterX(), Top(80))
        setupForm()
    }
    
    private func  setupForm() {
        textFields.forEach { $0.textField.delegate = self }
        scrollView.addSubviews(subviews: textFields)
        
        let nameLabel = Label(label: "name")
        let surnameLabel = Label(label: "surname")
        let emailLabel = Label(label: "email")
        let passwdLabel = Label(label: "password")
        let passwdConfirmLabel = Label(label: "confirm password")
        
        let labels = [nameLabel, surnameLabel, emailLabel, passwdLabel, passwdConfirmLabel]
        scrollView.addSubviews(subviews: labels)
        
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
        scrollView.addSubview(createAccountButton)
        createAccountButton.easy.layout(CenterX(), Top(40).to(passwdConfirmField, .bottom))
        createAccountButton.addGesture(target: self, selector: #selector(self.submitTapped(_:)))
        
//        let forgotPasswordButton = Label(label: "forgot password?")
//        container.addSubview(forgotPasswordButton)
//        forgotPasswordButton.easy.layout(CenterX(), Bottom(60))
//        forgotPasswordButton.addGesture(target: self, selector: #selector(self.forgotTapped(_:)))
    }
}

//MARK: UITextFieldDelegate
extension SignUpViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        dismissKeyboard()
        return true
    }
}

// MARK: Keyboard Handling
extension SignUpViewController {
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {

            var safeArea = self.view.frame
            safeArea.size.height += scrollView.contentOffset.y
            safeArea.size.height -= keyboardSize.height + (UIScreen.main.bounds.height*0.04) // Adjust buffer to your liking

            // determine which UIView was selected and if it is covered by keyboard
            let activeField: UIView? = [nameField, surnameField, emailField, passwdField, passwdConfirmField].first { $0.textField.isFirstResponder }
            if let activeField = activeField {
                if safeArea.contains(CGPoint(x: 0, y: activeField.frame.maxY)) {
                    print("No need to Scroll")
                    return
                } else {
                    distance = activeField.frame.maxY - safeArea.size.height
                    scrollOffset = scrollView.contentOffset.y
                    self.scrollView.setContentOffset(CGPoint(x: 0, y: scrollOffset + distance), animated: true)
                }
            }
            // prevent scrolling while typing
            scrollView.isScrollEnabled = false
        }
    }
    @objc func keyboardWillHide(notification: NSNotification) {
            if distance == 0 {
                return
            }
            // return to origin scrollOffset
            self.scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
            scrollOffset = 0
            distance = 0
            scrollView.isScrollEnabled = true
    }
}

// MARK: Routing
extension SignUpViewController {
    @objc private func cancelTapped(_ sender: UITapGestureRecognizer? = nil) {
        router.route(to: Route.cancel.rawValue, from: self)
    }
    @objc private func submitTapped(_ sender: UITapGestureRecognizer? = nil) {
        let enteredData = textFields.map { $0.textField.text }
        guard viewModel.verifyEnteredData(data: enteredData) else { return }
        router.route(to: Route.submit.rawValue, from: self)
    }
//    @objc private func forgotTapped(_ sender: UITapGestureRecognizer? = nil) {
//        router.route(to: Route.forgot.rawValue, from: self)
//    }
}

