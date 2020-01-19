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

class DashboardViewController: BasicComponentViewController {
    enum Route: String {
        case logout
        case weights
        case kcal
        case progress
    }
    private let router = DashboardRouter()
    private let viewModel = DashboardViewModel()
    
    private let weightTile = BasicTile(size: .small)
    private let kcalTile = BasicTile(size: .small)
    private let seeProgressTile = BasicTile(size: .wide)
    private let plusButton = BasicTile(size: .roundButton)
    private let healthClockTile = HealthClockView()
    
    let logoutButton = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtons()
    }
    
    override func setup(){
        super.setup()
        
        container.addSubviews(subviews: [healthClockTile, weightTile, kcalTile, seeProgressTile, plusButton])
        healthClockTile.easy.layout(CenterX(), Top(15).to(notchBorder, .bottom))
        
        weightTile.easy.layout(Left(19), Top(22).to(healthClockTile, .bottom))
        kcalTile.easy.layout(Right(19), Top(22).to(healthClockTile, .bottom))
        seeProgressTile.easy.layout(CenterX(), Top(22).to(kcalTile, .bottom))
        plusButton.easy.layout(CenterX(), Top(20).to(seeProgressTile, .bottom))
        
        weightTile.topLabel.text = "Weight"
        weightTile.bottomLabel.text = "kg"
        kcalTile.topLabel.text = "Calories"
        kcalTile.bottomLabel.text = "kcal"
        seeProgressTile.wideLabel.text = "See progress"
        
        weightTile.mainLabel.text = "75"
        kcalTile.mainLabel.text = "2490"
        
        logoutButton.image = UIImage(named: "logout")?.withTintColor(.white)
        container.addSubview(logoutButton)
        logoutButton.easy.layout(Top(40), Left(20), Size(40))
    }
    
    private func setupButtons() {
        weightTile.addGesture(target: self, selector: #selector(self.weightsTapped(_:)))
        kcalTile.addGesture(target: self, selector: #selector(self.kcalTapped(_:)))
        logoutButton.addGesture(target: self, selector: #selector(self.logoutTapped(_:)))
        seeProgressTile.addGesture(target: self, selector: #selector(self.seeProgressTapped(_:)))
        plusButton.addGesture(target: self, selector: #selector(self.addNewTapped(_:)))
    }
}

// MARK: Routing

extension DashboardViewController {
    @objc private func weightsTapped(_ sender: UITapGestureRecognizer? = nil) {
        router.route(to: Route.weights.rawValue, from: self)
    }
    
    @objc private func kcalTapped(_ sender: UITapGestureRecognizer? = nil) {
        router.route(to: Route.kcal.rawValue, from: self)
    }
    
    @objc private func logoutTapped(_ sender: UITapGestureRecognizer? = nil) {
        router.route(to: Route.logout.rawValue, from: self)
    }
    
    @objc private func seeProgressTapped(_ sender: UITapGestureRecognizer? = nil) {
        router.route(to: Route.progress.rawValue, from: self)
    }
    
    @objc private func addNewTapped(_ sender: UITapGestureRecognizer? = nil) {
        let popup = AddNewPopUp()
        present(popup, animated: true, completion: nil)
        popup.didMove(toParent: popup)
    }
}

