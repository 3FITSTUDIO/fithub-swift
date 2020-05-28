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
    }
    
    private let router = ProfileRouter()
    private let viewModel = ProfileViewModel(dataStore: mainStore.dataStore, userStore: mainStore.userStore)
    
    let helloLabel = Label(label: "Hello, ", fontSize: 30)
    let nameLabel: Label = {
        let label = Label(label: "", fontSize: 30)
        label.textColor = FithubUI.Colors.greenHighlight
        label.accessibilityIdentifier = "profileNameLabel"
        return label
    }()
    let dashboardButton = Button(type: .wide, label: "See dashboard")
    let notificationsButton = Button(type: .wide, label: "See notifications")
    let notificationsCountIcon = NotificationsCountIcon()
    
    private let logoutButton: UIView = {
        let gestureView = UIView()
        let logoutButton = UIImageView()
        gestureView.addSubview(logoutButton)
        gestureView.easy.layout(Size(50))
        logoutButton.easy.layout(Size(40), Center())
        logoutButton.image = UIImage(named: "logout")?.withTintColor(.white)
        return gestureView
    }()
    
    private let refreshButton: UIView = {
        let gestureView = UIView()
        let refreshButton = UIImageView()
        gestureView.addSubview(refreshButton)
        gestureView.easy.layout(Size(50))
        refreshButton.easy.layout(Size(40), Center())
        refreshButton.image = UIImage(named: "refresh")?.withTintColor(.white)
        return gestureView
    }()
    
    private let stepsProgressView = StepsProgressBarView()
    
    override func viewDidLoad() {
        componentName = "Profile"
        super.viewDidLoad()
        viewModel.vc = self
        layout()
        setupButtonInteractions()
        viewModel.updateData(force: true)
    }
    
    private func layout() {
        container.addSubviews(subviews: [helloLabel, nameLabel, stepsProgressView, dashboardButton, notificationsButton, logoutButton, refreshButton])
        helloLabel.easy.layout(Left(80), Top(120))
        nameLabel.easy.layout(Left(5).to(helloLabel), Top(120))
        let userName = viewModel.getUserName()
        nameLabel.text = userName
        
        stepsProgressView.easy.layout(CenterX(), Top(30).to(helloLabel, .bottom))
        dashboardButton.easy.layout(Top(25).to(stepsProgressView), CenterX())
        notificationsButton.easy.layout(Top(25).to(dashboardButton), CenterX())
        logoutButton.easy.layout(Top(40), Left(20), Size(40))
        refreshButton.easy.layout(Top(40), Right(20), Size(40))
        notificationsButton.addSubview(notificationsCountIcon)
        notificationsCountIcon.easy.layout(CenterY(), Right(30))
    }
    
    private func setupButtonInteractions() {
        dashboardButton.addGesture(target: self, selector: #selector(dashboardTapped(_:)))
        notificationsButton.addGesture(target: self, selector: #selector(notificationsTapped(_:)))
        logoutButton.addGesture(target: self, selector: #selector(self.logoutTapped(_:)))
    }
    
    func rotateRefreshButton() {
        let rotation: CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = Double.pi * 2
        rotation.duration = 0.5
        rotation.isCumulative = true
        rotation.repeatCount = 2
        refreshButton.layer.add(rotation, forKey: "rotationAnimation")
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
}
