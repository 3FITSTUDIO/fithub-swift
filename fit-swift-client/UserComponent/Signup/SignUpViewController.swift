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
    private let router = SignUpRouter()
    private let viewModel = SignUpViewModel()
    
    private var scrollOffset : CGFloat = 0
    private var distance : CGFloat = 0
    
    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.contentSize.height = 1100
        return view
    }()
    
    private let nameField = TextField()
    private let surnameField = TextField()
    private let emailField = TextField()
    private let loginField = TextField()
    private let passwdField = PasswordField()
    private let passwdConfirmField = PasswordField()
    private let sexField = TextField()
    private let heightField = TextField()
    private let yearOfBirthField = TextField()
    private var textFields = [TextField]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        setupCommonTraits()
        setup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCommonTraits()
        textFields = [nameField, surnameField, emailField, loginField, passwdField, passwdConfirmField, sexField, heightField, yearOfBirthField]
        setup()
        viewModel.vc = self
    }
    
    private func setup(){
        view.addSubview(scrollView)
        scrollView.easy.layout(Top(0), Bottom(20), Left(), Right())
        
        let logo = UIImageView()
        logo.image = UIImage(named: "logo-text")
        scrollView.addSubview(logo)
        logo.image = ImageUtility.resizeImage(image: logo.image, toScale: 0.7)
        logo.easy.layout(CenterX(), Top(40))
        setupForm()
    }
    
    private func  setupForm() {
        textFields.forEach { $0.textField.delegate = self }
        scrollView.addSubviews(subviews: textFields)
        
        let nameLabel = Label(label: "name")
        let surnameLabel = Label(label: "surname")
        let emailLabel = Label(label: "email")
        let loginLabel = Label(label: "login")
        let passwdLabel = Label(label: "password")
        let passwdConfirmLabel = Label(label: "confirm password")
        let sexLabel = Label(label: "sex (M/F)")
        let heightLabel = Label(label: "height (cm)")
        let yearLabel = Label(label: "year of birth")
        
        let labels = [nameLabel, surnameLabel, emailLabel, loginLabel, passwdLabel, passwdConfirmLabel, sexLabel, heightLabel, yearLabel]
        scrollView.addSubviews(subviews: labels)
        
        nameField.easy.layout(CenterX(), Top(150))
        var previous = nameField
        let rest = [surnameField, emailField, loginField, passwdField, passwdConfirmField, sexField, heightField, yearOfBirthField]
        rest.forEach {
            $0.easy.layout(CenterX(), Top(41).to(previous, .bottom))
            previous = $0
        }
        
        nameLabel.easy.layout(Left(82), Top(125))
        let rest2 = [surnameLabel, emailLabel, loginLabel, passwdLabel, passwdConfirmLabel, sexLabel, heightLabel, yearLabel]
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
        createAccountButton.easy.layout(CenterX(), Top(40).to(yearOfBirthField, .bottom))
        createAccountButton.addGesture(target: self, selector: #selector(self.submitTapped(_:)))
        
        let cancelButton = Button(type: .small, label: "cancel")
        scrollView.addSubview(cancelButton)
        cancelButton.easy.layout(CenterX(), Top(30).to(createAccountButton, .bottom))
        cancelButton.addGesture(target: self, selector: #selector(self.cancelTapped))
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
            let activeField: UIView? = [nameField, surnameField, emailField, loginField, passwdField, passwdConfirmField, sexField, heightField, yearOfBirthField].first { $0.textField.isFirstResponder }
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
            scrollView.isScrollEnabled = true
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

// MARK: Display Alerts
extension SignUpViewController {
    enum AlertType {
        case invalidPassword
        case passwordsDontMatch
        case emptyFields
        case success
    
    }
    public func displayAlert(type: AlertType) {
        switch type {
        case .invalidPassword:
            let alertController = UIAlertController(title: "Oh no!", message: "Password needs to have min. 8 characters (1 number)!", preferredStyle: .alert)
            let action1 = UIAlertAction(title: "Try again", style: .default) { [weak self] (action:UIAlertAction) in
                [self?.passwdField, self?.passwdConfirmField].forEach { $0?.textField.text = "" }
            }
            alertController.addAction(action1)
            self.present(alertController, animated: true, completion: nil)
            return
        case .passwordsDontMatch:
            let alertController = UIAlertController(title: "Oh no!", message: "Passwords don't match!!", preferredStyle: .alert)
            let action1 = UIAlertAction(title: "Try again", style: .default) { [weak self] (action:UIAlertAction) in
                [self?.passwdField, self?.passwdConfirmField].forEach { $0?.textField.text = "" }
            }
            alertController.addAction(action1)
            self.present(alertController, animated: true, completion: nil)
            return
        case .emptyFields:
            let alertController = UIAlertController(title: "Oh no!", message: "Some fields were left empty!", preferredStyle: .alert)
            let action1 = UIAlertAction(title: "Try again", style: .default) { (action:UIAlertAction) in }
            alertController.addAction(action1)
            self.present(alertController, animated: true, completion: nil)
            return
        case .success:
            let alertController = UIAlertController(title: "Success!", message: "Signed up correctly.", preferredStyle: .alert)
            let action1 = UIAlertAction(title: "Log in", style: .default) { (action:UIAlertAction) in
                self.router.route(to: Route.submit.rawValue, from: self)
            }
            alertController.addAction(action1)
            self.present(alertController, animated: true, completion: nil)
        }
    }
}

// MARK: Routing
extension SignUpViewController {
    @objc private func cancelTapped(_ sender: UITapGestureRecognizer? = nil) {
        generator.selectionChanged()
        router.route(to: Route.cancel.rawValue, from: self)
    }
    @objc private func submitTapped(_ sender: UITapGestureRecognizer? = nil) {
        generator.selectionChanged()
        let enteredData = textFields.map { $0.textField.text }
        viewModel.verifyEnteredData(data: enteredData)
    }
}

