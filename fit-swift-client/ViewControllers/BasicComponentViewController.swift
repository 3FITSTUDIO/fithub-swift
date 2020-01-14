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
    
    let container = UIView()
    var componentName = "Dashboard"
    
    let notchBorder = UIView()
    let bottomNavigationBar = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        self.view.backgroundColor = FithubUI.Colors.weirdGreen
        setup()
    }
    
    func setup() {
        view.addSubview(container)
        container.easy.layout(Edges())
        setupNotchBorder()
    }
    
    private func setupNotchBorder() {
        let componentNameLabel = Label(label: componentName, fontSize: 20)
        notchBorder.addSubview(componentNameLabel)

        notchBorder.layer.cornerRadius = 20
        notchBorder.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        notchBorder.layer.borderColor = FithubUI.Colors.whiteOneHundred.cgColor
        notchBorder.layer.borderWidth = 5
        
        notchBorder.easy.layout(Width(200), Height(80))
        componentNameLabel.easy.layout(CenterX(), Bottom(15))
        
        self.view.addSubview(notchBorder)
        notchBorder.easy.layout(CenterX(), Top(0))
    }
    
    func addBottomNavigationBar() {
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
    @objc func backButtonTapped(_ sender: UITapGestureRecognizer? = nil) {
        fatalError("backButtonTapped not implemented")
    }
}
