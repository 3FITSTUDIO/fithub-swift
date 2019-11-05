//
//  DashboardViewController.swift
//  fit-swift-client
//
//  Created by admin on 05/11/2019.
//  Copyright © 2019 Dominik Urbaez Gomez. All rights reserved.
//

import Foundation
import UIKit
import EasyPeasy

class DashboardViewController: UIViewController {
    enum Route: String {
        case logout
    }
    var router = DashboardRouter()
    var viewModel = LoginViewModel()
    
    
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
    
        setupButtons()
    }
    
    private func setupButtons() {
        let logoutButton = Button(label: "logout")
        container.addSubview(logoutButton)
        logoutButton.easy.layout(CenterX(), Bottom(30))
        logoutButton.addGesture(target: self, selector: #selector(self.logoutButtonTapped(_:)))
    }
}

// MARK: Routing

extension DashboardViewController {
    @objc private func logoutButtonTapped(_ sender: UITapGestureRecognizer? = nil) {
        router.route(to: Route.logout.rawValue, from: self)
    }
}

