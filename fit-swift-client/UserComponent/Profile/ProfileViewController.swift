//
//  ProfileViewController.swift
//  fit-swift-client
//
//  Created by admin on 18/05/2020.
//  Copyright © 2020 Dominik Urbaez Gomez. All rights reserved.
//

import Foundation
import UIKit
import EasyPeasy

class ProfileViewController: BasicComponentViewController {
    enum Route: String {
        case logout
        case dashboard
        case notifications
        case settings
    }
    
    private let router = ProfileRouter()
    private let viewModel = ProfileViewModel()
    
    let helloLabel = Label(label: "Hello, ", fontSize: 30)
    let nameLabel: Label = {
        let label = Label(label: "", fontSize: 30)
        label.textColor = FithubUI.Colors.highlight
        return label
    }()
    let dashboardButton = Button(type: .wide, label: "See dashboard")
    let notificationsButton = Button(type: .wide, label: "See notifications")
    
    private let logoutButton: UIView = {
        let gestureView = UIView()
        let logoutButton = UIImageView()
        gestureView.addSubview(logoutButton)
        gestureView.easy.layout(Size(50))
        logoutButton.easy.layout(Size(40), Center())
        logoutButton.image = UIImage(named: "logout")?.withTintColor(.white)
        return gestureView
    }()
    
    private let settingsButton: UIView = {
        let gestureView = UIView()
        let logoutButton = UIImageView()
        gestureView.addSubview(logoutButton)
        gestureView.easy.layout(Size(50))
        logoutButton.easy.layout(Size(40), Center())
        logoutButton.image = UIImage(named: "settings")?.withTintColor(.white)
        return gestureView
    }()
    
    private let stepsProgressView = StepsProgressBarView()
    
    override func viewDidLoad() {
        componentName = "Profile"
        super.viewDidLoad()
        viewModel.vc = self
        layout()
        setupButtonInteractions()
    }
    
    private func layout() {
        container.addSubviews(subviews: [helloLabel, nameLabel, stepsProgressView, dashboardButton, notificationsButton, logoutButton, settingsButton])
        helloLabel.easy.layout(Left(80), Top(100))
        nameLabel.easy.layout(Left(5).to(helloLabel), Top(100))
        let userName = viewModel.getUserName()
        nameLabel.text = userName
        
        stepsProgressView.easy.layout(CenterX(), Top(20).to(helloLabel, .bottom))
        dashboardButton.easy.layout(Top(20).to(stepsProgressView), CenterX())
        notificationsButton.easy.layout(Top(20).to(dashboardButton), CenterX())
        logoutButton.easy.layout(Top(40), Left(20), Size(40))
        settingsButton.easy.layout(Top(40), Right(20), Size(40))
    }
    
    private func setupButtonInteractions() {
        dashboardButton.addGesture(target: self, selector: #selector(dashboardTapped(_:)))
        notificationsButton.addGesture(target: self, selector: #selector(notificationsTapped(_:)))
        logoutButton.addGesture(target: self, selector: #selector(self.logoutTapped(_:)))
        settingsButton.addGesture(target: self, selector: #selector(self.settingsTapped(_:)))
    }
    
    // MARK: Navigation
    
    @objc private func dashboardTapped(_ sender: UITapGestureRecognizer? = nil) {
        generator.selectionChanged()
        router.route(to: Route.dashboard.rawValue, from: self)
    }
    
    @objc private func notificationsTapped(_ sender: UITapGestureRecognizer? = nil) {
        generator.selectionChanged()
        viewModel.triggerNotificationsFetch {
            self.router.route(to: Route.notifications.rawValue, from: self)
        }
    }
    
    @objc private func logoutTapped(_ sender: UITapGestureRecognizer? = nil) {
        generator.selectionChanged()
        viewModel.clearProfileOnLogout()
        router.route(to: Route.logout.rawValue, from: self)
    }
    
    @objc private func settingsTapped(_ sender: UITapGestureRecognizer? = nil) {
        generator.selectionChanged()
        router.route(to: Route.settings.rawValue, from: self, parameters: viewModel)
    }
}
