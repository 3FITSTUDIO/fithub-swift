//
//  BasicComponentViewController.swift
//  fit-swift-client
//
//  Created by admin on 04/12/2019.
//  Copyright © 2019 Dominik Urbaez Gomez. All rights reserved.
//

import UIKit
import EasyPeasy

class BasicComponentViewController: UIViewController {
    
    private let notchBorder = UIView()
    private let bottomNavigationBar = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        self.view.backgroundColor = FithubUI.Colors.weirdGreen
        setup()
    }
    
    private func setup() {
        setupNotchBorder()
    }
    
    private func setupNotchBorder() {
        let componentName = Label(label: "Dashboard", fontSize: 20)
        notchBorder.addSubview(componentName)

        notchBorder.layer.cornerRadius = 20
        notchBorder.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        notchBorder.layer.borderColor = FithubUI.Colors.whiteOneHundred.cgColor
        notchBorder.layer.borderWidth = 5
        
        notchBorder.easy.layout(Width(200), Height(80))
        componentName.easy.layout(CenterX(), Bottom(15))
        
        self.view.addSubview(notchBorder)
        notchBorder.easy.layout(CenterX(), Top(0))
    }
    
    private func addBottomNavigationBar() {
        let bottomNavigationBar = UIView()
        bottomNavigationBar.backgroundColor = FithubUI.Colors.hospitalGreen
        let backButton = Button(type: .nav, label: "back")
        bottomNavigationBar.addSubview(backButton)
        backButton.easy.layout(Center())
        backButton.addGesture(target: self, selector: #selector(self.backButtonTapped(_:)))
        
        self.view.addSubview(bottomNavigationBar)
        bottomNavigationBar.easy.layout(Left(), Right(), Bottom(), Height(110))
    }
    
    // MARK: - Navigation
    @objc private func backButtonTapped(_ sender: UITapGestureRecognizer? = nil) {
        fatalError("backButtonTapped not implemented")
    }
}
